-- PostgreSQL
CREATE OR REPLACE PROCEDURE listar_habitaciones_reservadas(p_nombre_hotel VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    cur_habitaciones CURSOR FOR
        SELECT ah.idReserva, ah.idHabitacion, h.nroHabitacion, a.nombre AS nombreHotel
        FROM asociadaAHabitacion ah
        JOIN Habitacion h ON h.idHabitacion = ah.idHabitacion
                          AND h.idAlojamiento = ah.idAlojamiento
        JOIN Alojamiento a ON a.idAlojamiento = ah.idAlojamiento
        WHERE a.nombre ILIKE '%' || p_nombre_hotel || '%'
        ORDER BY ah.idReserva;
    reg RECORD;
BEGIN
    OPEN cur_habitaciones;
    LOOP
        FETCH cur_habitaciones INTO reg;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Reserva %: habitación % (n° %) en %',
            reg.idReserva, reg.idHabitacion, reg.nroHabitacion, reg.nombreHotel;
    END LOOP;
    CLOSE cur_habitaciones;
END;
$$;

CALL listar_habitaciones_reservadas('Andes');


-- MySQL
DELIMITER $$

CREATE PROCEDURE listar_habitaciones_reservadas(IN p_nombre_hotel VARCHAR(100))
BEGIN
    DECLARE v_idReserva INT;
    DECLARE v_idHabitacion INT;
    DECLARE v_nroHabitacion INT;
    DECLARE v_nombreHotel VARCHAR(100);
    DECLARE v_done INT DEFAULT 0;

    DECLARE cur_habitaciones CURSOR FOR
        SELECT ah.idReserva, ah.idHabitacion, h.nroHabitacion, a.nombre
        FROM asociadaAHabitacion ah
        JOIN Habitacion h ON h.idHabitacion = ah.idHabitacion
                          AND h.idAlojamiento = ah.idAlojamiento
        JOIN Alojamiento a ON a.idAlojamiento = ah.idAlojamiento
        WHERE a.nombre LIKE CONCAT('%', p_nombre_hotel, '%')
        ORDER BY ah.idReserva;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    DROP TEMPORARY TABLE IF EXISTS tmp_resultado;
    CREATE TEMPORARY TABLE tmp_resultado (linea VARCHAR(200));

    OPEN cur_habitaciones;

    read_loop: LOOP
        FETCH cur_habitaciones INTO v_idReserva, v_idHabitacion, v_nroHabitacion, v_nombreHotel;
        IF v_done = 1 THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO tmp_resultado (linea)
        VALUES (CONCAT('Reserva ', v_idReserva, ': habitación ', v_idHabitacion,
                        ' (n° ', v_nroHabitacion, ') en ', v_nombreHotel));
    END LOOP;

    CLOSE cur_habitaciones;

    SELECT * FROM tmp_resultado;
    DROP TEMPORARY TABLE tmp_resultado;
END$$

DELIMITER ;

CALL listar_habitaciones_reservadas('Andes');