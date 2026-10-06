-- PostgreSQL
CREATE OR REPLACE FUNCTION eliminar_alojamiento_us()
RETURNS  TRIGGER AS $$
BEGIN 
         
           DELETE FROM asociadaAHabitacion aah
           USING Habitacion h
           JOIN Alojamiento a ON a.idAlojamiento = h.idAlojamiento
           WHERE aah.idHabitacion = h.idHabitacion 
                 AND aah.idAlojamiento = h.idAlojamiento
                 AND a.idUsuario = OLD.idUsuario; 

           DELETE FROM Reserva_Particular rp
           USING Particular p
           JOIN Alojamiento a ON a.idAlojamiento = p.idAlojamiento
           WHERE rp.idAlojamiento = p.idAlojamiento 
                 AND a.idUsuario = OLD.idUsuario; 

           DELETE FROM Alojamiento
           WHERE idUsuario = OLD.idUsuario; 

           DELETE FROM Mensajeria
           WHERE idUsuarioAlojamiento = OLD.idUsuario; 

           RETURN OLD; 
END; 
$$ LANGUAGE plpgsql; 

CREATE TRIGGER eliminar_usuario_alojamiento
BEFORE DELETE ON Usuario_Alojamiento
FOR EACH ROW
EXECUTE FUNCTION eliminar_alojamiento_us()



-- MySQL
DROP TRIGGER IF EXISTS eliminar_usuario_alojamiento
DELIMITER $$

CREATE TRIGGER eliminar_usuario_alojamiento 
BEFORE DELETE ON Usuario_Alojamiento
FOR EACH ROW
BEGIN
       
         DELETE aah FROM asociadaAHabitacion aah 
         JOIN Habitacion h ON  aah.idHabitacion = h.idHabitacion
                 AND aah.idAlojamiento = h.idAlojamiento
         JOIN Alojamiento a ON a.idAlojamiento = h.idAlojamiento
         WHERE a.idUsuario = OLD.idUsuario; 

         DELETE rp FROM Reserva_Particular rp 
         JOIN Particular p ON rp.idAlojamiento = p.idAlojamiento
         JOIN Alojamiento a ON  a.idAlojamiento = p.idAlojamiento
         WHERE a.idUsuario = OLD.idUsuario; 

         DELETE FROM Alojamiento 
         WHERE idUsuario = OLD.idUsuario; 

         DELETE FROM Mensajeria
         WHERE idUsuarioAlojamiento = OLD.idUsuario;


END $$

DELIMITER ;

