-- a) 

-- PostgreSQL 
SET search_path TO esquema_grupo1;

CREATE OR REPLACE FUNCTION fn_reservas_periodo(p_desde DATE, p_hasta DATE)
RETURNS TABLE (
    formato TEXT
)
LANGUAGE sql
AS $$
    SELECT
        'La reserva ' || r.idReserva ||
        ' del ' || TO_CHAR(r.fechaInicio, 'DD/MM/YYYY') ||
        ' en ' || a.nombre ||
        CASE WHEN p.idAlojamiento IS NOT NULL
             THEN ' (particular)'
             ELSE ' (hotel, habitaciones ' ||
                  STRING_AGG(h.nroHabitacion::TEXT, ', ' ORDER BY h.nroHabitacion) || ')'
        END ||
        ', para ' || r.cantPersonas || ' personas y ' ||
        (r.fechaFin - r.fechaInicio) || ' noches, tiene un total de $' ||
        COALESCE(p.precioPorNoche, SUM(h.precioPorNoche)) * (r.fechaFin - r.fechaInicio)
    FROM reserva r
    LEFT JOIN reserva_particular rp  ON rp.idReserva = r.idReserva
    LEFT JOIN particular p           ON p.idAlojamiento = rp.idAlojamiento
    LEFT JOIN asociadaAHabitacion ah ON ah.idReserva = r.idReserva
    LEFT JOIN habitacion h           ON h.idHabitacion = ah.idHabitacion
                                    AND h.idAlojamiento = ah.idAlojamiento
    JOIN alojamiento a ON a.idAlojamiento = COALESCE(rp.idAlojamiento, ah.idAlojamiento)
    WHERE r.fechaInicio BETWEEN p_desde AND p_hasta
    GROUP BY r.idReserva, r.fechaInicio, r.fechaFin, r.cantPersonas,
             a.nombre, p.idAlojamiento, p.precioPorNoche
    ORDER BY r.fechaInicio;
$$;

SELECT * FROM fn_reservas_periodo('2026-01-01', '2027-12-31');


--MySQL
DELIMITER $$

CREATE PROCEDURE sp_reservas_periodo(
    IN p_desde DATE,
    IN p_hasta DATE
)
BEGIN
    SELECT CONCAT(
               'La reserva ', r.idReserva,
               ' del ', DATE_FORMAT(r.fechaInicio, '%d/%m/%Y'),
               ' en ', a.nombre,
               CASE WHEN p.idAlojamiento IS NOT NULL
                    THEN ' (particular)'
                    ELSE CONCAT(' (hotel, habitaciones ',
                                GROUP_CONCAT(h.nroHabitacion ORDER BY h.nroHabitacion SEPARATOR ', '),
                                ')')
               END,
               ', para ', r.cantPersonas, ' personas y ',
               DATEDIFF(r.fechaFin, r.fechaInicio), ' noches, tiene un total de $',
               COALESCE(p.precioPorNoche, SUM(h.precioPorNoche)) * DATEDIFF(r.fechaFin, r.fechaInicio)
           ) AS formato
    FROM Reserva r
    -- rama particular
    LEFT JOIN Reserva_Particular rp  ON rp.idReserva = r.idReserva
    LEFT JOIN Particular p           ON p.idAlojamiento = rp.idAlojamiento
    -- rama hotel
    LEFT JOIN asociadaAHabitacion ah ON ah.idReserva = r.idReserva
    LEFT JOIN Habitacion h           ON h.idHabitacion = ah.idHabitacion
                                    AND h.idAlojamiento = ah.idAlojamiento
    JOIN Alojamiento a ON a.idAlojamiento = COALESCE(rp.idAlojamiento, ah.idAlojamiento)
    WHERE r.fechaInicio BETWEEN p_desde AND p_hasta
    GROUP BY r.idReserva, r.fechaInicio, r.fechaFin, r.cantPersonas,
             a.nombre, p.idAlojamiento, p.precioPorNoche
    ORDER BY r.fechaInicio;
END$$

DELIMITER ;



-- b) 

-- PostgreSQL
CREATE OR REPLACE FUNCTION diferencia_meses(fecha1 DATE, fecha2 DATE)
RETURNS INTEGER AS $$
DECLARE
    anio1 INTEGER;
    anio2 INTEGER;
    mes1  INTEGER;
    mes2  INTEGER;
    dif_meses INTEGER;
BEGIN
    
    anio1 := EXTRACT(YEAR FROM fecha1);
    anio2 := EXTRACT(YEAR FROM fecha2);
    mes1  := EXTRACT(MONTH FROM fecha1);
    mes2  := EXTRACT(MONTH FROM fecha2);

    dif_meses := (anio2 - anio1) * 12 + (mes2 - mes1);

    RETURN ABS(dif_meses);
END;
$$ LANGUAGE plpgsql;


-- MySQL
DELIMITER $$

CREATE FUNCTION diferencia_meses(fecha1 DATE, fecha2 DATE)
RETURNS INTEGER
DETERMINISTIC
BEGIN
    DECLARE anio1 INTEGER;
    DECLARE anio2 INTEGER;
    DECLARE mes1  INTEGER;
    DECLARE mes2  INTEGER;
    DECLARE dif_meses INTEGER;

    SET anio1 = EXTRACT(YEAR FROM fecha1);
    SET anio2 = EXTRACT(YEAR FROM fecha2);
    SET mes1  = EXTRACT(MONTH FROM fecha1);
    SET mes2  = EXTRACT(MONTH FROM fecha2);

    SET dif_meses = (anio2 - anio1) * 12 + (mes2 - mes1);

    RETURN ABS(dif_meses);
END$$

DELIMITER ;

