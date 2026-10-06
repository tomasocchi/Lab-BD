-- PostgreSQL

SET search_path TO esquema_grupo1;

CREATE OR REPLACE FUNCTION antiguedad_cliente(p_idUsuario INTEGER)
RETURNS TEXT
AS $$
DECLARE
    v_fecha_alta DATE;
    v_anios  INTEGER;
    v_meses  INTEGER;
    v_dias   INTEGER;
BEGIN
    SELECT fecha_alta INTO v_fecha_alta
    FROM usuario_cliente
    WHERE idUsuario = p_idUsuario;

    IF v_fecha_alta IS NULL THEN
        RETURN 'Registro no encontrado';
    END IF;

    v_anios := EXTRACT(YEAR  FROM AGE(CURRENT_DATE, v_fecha_alta));
    v_meses := EXTRACT(MONTH FROM AGE(CURRENT_DATE, v_fecha_alta));
    v_dias  := EXTRACT(DAY   FROM AGE(CURRENT_DATE, v_fecha_alta));

    RETURN v_anios || ' años, ' || v_meses || ' meses, ' || v_dias || ' días';
END;
$$ LANGUAGE plpgsql;


-- MySQL

DELIMITER $$
CREATE FUNCTION antiguedad_cliente(p_idUsuario INT)
RETURNS VARCHAR(60)
READS SQL DATA
BEGIN
    DECLARE v_fecha_alta DATE;
    DECLARE v_anios INT;
    DECLARE v_meses INT;
    DECLARE v_dias  INT;

    SELECT fecha_alta INTO v_fecha_alta
    FROM Usuario_Cliente
    WHERE idUsuario = p_idUsuario;

    IF v_fecha_alta IS NULL THEN
        RETURN 'Registro no encontrado';
    END IF;

    SET v_anios = TIMESTAMPDIFF(YEAR, v_fecha_alta, CURDATE());
    SET v_meses = TIMESTAMPDIFF(MONTH, v_fecha_alta, CURDATE()) - (v_anios * 12);
    SET v_dias  = DATEDIFF(CURDATE(),
                           DATE_ADD(v_fecha_alta,
                                    INTERVAL TIMESTAMPDIFF(MONTH, v_fecha_alta, CURDATE()) MONTH));

    RETURN CONCAT(v_anios, ' años, ', v_meses, ' meses, ', v_dias, ' días');
END$$
DELIMITER ;



-- para probrarlo
SELECT idUsuario, fecha_alta, antiguedad_cliente(idUsuario) AS antiguedad
FROM usuario_cliente
ORDER BY idUsuario;
