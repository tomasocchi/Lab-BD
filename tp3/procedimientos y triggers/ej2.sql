-- PostgreSQL 
CREATE OR REPLACE FUNCTION esquema_grupo1.incrementar_reservas()
RETURNS TRIGGER AS $$
BEGIN
    -- solo las reservas del año actual
    IF EXTRACT(YEAR FROM NEW.fechaInicio) = EXTRACT(YEAR FROM CURRENT_DATE) THEN
        UPDATE esquema_grupo1.usuario_cliente
        SET cantidadReservasAnio = cantidadReservasAnio + 1
        WHERE idUsuario = NEW.idUsuarioCliente;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS agregarReserva ON esquema_grupo1.reserva;

CREATE TRIGGER agregarReserva
AFTER INSERT ON esquema_grupo1.reserva
FOR EACH ROW
EXECUTE FUNCTION esquema_grupo1.incrementar_reservas();


--MySQL
DELIMITER $$

CREATE TRIGGER agregarReserva
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF YEAR(NEW.fechaInicio) = YEAR(CURDATE()) THEN
        UPDATE usuario_cliente
        SET cantidadReservasAnio = cantidadReservasAnio + 1
        WHERE idUsuario = NEW.idUsuarioCliente;
    END IF;
END $$

DELIMITER ;