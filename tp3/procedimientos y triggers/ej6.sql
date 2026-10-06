-- PostgreSQL
CREATE OR REPLACE FUNCTION esquema_grupo1.verificar_usuario() 
RETURNS TRIGGER AS $$ 
DECLARE cantReservas INT;
BEGIN 
	SELECT COUNT(idReserva) INTO cantReservas 
      FROM reserva r
	WHERE r.idUsuarioCliente = NEW.idUsuarioCliente AND EXTRACT(YEAR FROM(r.fechaInicio)) = EXTRACT(YEAR FROM(NEW.fechaInicio));

	IF (cantReservas >= 10) THEN
	RAISE NOTICE 'La reserva no se puede concretar ya que el cliente % ya realizó % reservas en el año %', NEW.idUsuarioCliente, cantReservas, EXTRACT(YEAR FROM NEW.fechaInicio);
     	RETURN NULL;
END IF;
	RETURN NEW;
END; 
$$ LANGUAGE plpgsql; 
  
CREATE TRIGGER verificarLimiteReservas
BEFORE INSERT ON esquema_grupo1.reserva
FOR EACH ROW
EXECUTE FUNCTION esquema_grupo1.verificar_usuario();


-- MySQL
DELIMITER $$ 
  
CREATE TRIGGER verificarLimiteReservas
BEFORE INSERT ON reserva
FOR EACH ROW
BEGIN
	DECLARE cantReservas INT;

	SELECT COUNT(idReserva) INTO cantReservas 
      FROM reserva r
	WHERE r.idUsuarioCliente = NEW.idUsuarioCliente AND YEAR(r.fechaInicio) = YEAR(NEW.fechaInicio);

	IF (cantReservas >= 10) THEN
      	SIGNAL SQLSTATE '45000'

	SET MESSAGE_TEXT = CONCAT('La reserva no se puede concretar ya que el cliente ', NEW.idUsuarioCliente,' ya realizó ', cantReservas, ' reservas en el año ', EXTRACT(YEAR FROM NEW.fechaInicio));

END IF;
END $$

DELIMITER ;
