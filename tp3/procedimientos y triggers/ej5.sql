-- PostgreSQL
CREATE OR REPLACE FUNCTION esquema_grupo1.registro_log_reserva()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO esquema_grupo1.LOG_planillaControl(operacion)
    VALUES (TG_OP);

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_reserva
AFTER INSERT OR UPDATE OR DELETE ON esquema_grupo1.Reserva
FOR EACH STATEMENT
EXECUTE FUNCTION esquema_grupo1.registro_log_reserva();


-- MySQL
-- Trigger realizado para MySQL con simulación FOR EACH STATEMENT
DELIMITER $$

CREATE TRIGGER trg_insertar_log_reserva
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF @ts_insertar_log_reserva IS NULL OR @ts_insertar_log_reserva <> CURRENT_TIMESTAMP(6) THEN
        INSERT INTO LOG_planillaControl(operacion) VALUES ('INSERT');
        SET @ts_insertar_log_reserva = CURRENT_TIMESTAMP(6);
    END IF;
END$$

CREATE TRIGGER trg_modificar_log_reserva
AFTER UPDATE ON Reserva
FOR EACH ROW
BEGIN
    IF @ts_modificar_log_reserva IS NULL OR @ts_modificar_log_reserva <> CURRENT_TIMESTAMP(6) THEN
        INSERT INTO LOG_planillaControl(operacion) VALUES ('UPDATE');
        SET @ts_modificar_log_reserva = CURRENT_TIMESTAMP(6);
    END IF;
END$$

CREATE TRIGGER trg_borrar_log_reserva
AFTER DELETE ON Reserva
FOR EACH ROW
BEGIN
    IF @ts_borrar_log_reserva IS NULL OR @ts_borrar_log_reserva<> CURRENT_TIMESTAMP(6) THEN
        INSERT INTO LOG_planillaControl(operacion) VALUES ('DELETE');
        SET @ts_borrar_log_reserva = CURRENT_TIMESTAMP(6);
    END IF;
END$$

DELIMITER ;

