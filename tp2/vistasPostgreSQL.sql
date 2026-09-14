--------------------------------------- PostgreSQL ---------------------------------------  

-- Vista con LOCAL CHECK OPTION
SET search_path TO esquema_grupo1;
CREATE VIEW VistaLocal AS 
SELECT rp.* 
FROM Reserva_Particular rp 
WHERE rp.idReserva IN (
        SELECT r.idReserva 
        FROM Reserva r
        WHERE EXTRACT(YEAR FROM r.fechaInicio) = EXTRACT(YEAR FROM CURRENT_DATE) ) 
WITH LOCAL CHECK OPTION; 


-- Vista con CASCADE CHECK OPTION
SET search_path TO esquema_grupo1;
CREATE VIEW VistaCascade AS 
SELECT rp.* 
FROM Reserva_Particular rp 
WHERE rp.idReserva IN (
        SELECT r.idReserva 
        FROM Reserva r
        WHERE EXTRACT(YEAR FROM r.fechaInicio) = EXTRACT(YEAR FROM CURRENT_DATE) ) 
WITH CASCADED CHECK OPTION; 



-- Vista anidada - LOCAL CHECK OPTION
SET search_path TO esquema_grupo1;
CREATE VIEW VistaLocal2 AS 
SELECT v.* FROM VistaLocal v 
WHERE EXISTS ( 
        SELECT 1 
        FROM Particular p JOIN Alojamiento a ON a.idAlojamiento = p.idAlojamiento 
        WHERE p.idAlojamiento = v.idAlojamiento 
             AND a.ciudad = 'Bariloche' )
             AND EXISTS (
                      SELECT 1 
                      FROM Particular p 
                      WHERE p.idAlojamiento = v.idAlojamiento AND p.capacidad >= 4 ) 
             AND EXISTS ( 
                    SELECT 1 
                    FROM Reserva r 
                    WHERE r.idReserva = v.idReserva AND r.precioTotal > 100000 ) 
WITH LOCAL CHECK OPTION;


-- Vista anidada - CASCADED CHECK OPTION
SET search_path TO esquema_grupo1;
CREATE VIEW VistaCascade2 AS 
SELECT v.* FROM VistaCascade v 
WHERE EXISTS ( 
        SELECT 1 
        FROM Particular p JOIN Alojamiento a ON a.idAlojamiento = p.idAlojamiento 
        WHERE p.idAlojamiento = v.idAlojamiento 
             AND a.ciudad = 'Bariloche' )
             AND EXISTS (
                      SELECT 1 
                      FROM Particular p 
                      WHERE p.idAlojamiento = v.idAlojamiento AND p.capacidad >= 4 ) 
             AND EXISTS ( 
                    SELECT 1 
                    FROM Reserva r 
                    WHERE r.idReserva = v.idReserva AND r.precioTotal > 100000 ) 
WITH CASCADED CHECK OPTION;


-- Vista con JOIN y WITH CHECK OPTION
SET search_path TO esquema_grupo1;
CREATE VIEW info_clientes_frecuentes as
SELECT c.*, r.* 
FROM usuario_cliente c JOIN reserva r ON c.idUsuario = r.idUsuarioCliente 
WHERE c.idUsuario IN (
    SELECT r2.idUsuarioCliente
    FROM reserva r2
    GROUP BY r2.idUsuarioCliente 
    HAVING COUNT (r2.idUsuarioCliente) > 3
)
WITH LOCAL CHECK OPTION;



-- Vista con JOIN y sin WITH CHECK OPTION.
SET search_path TO esquema_grupo1;
CREATE VIEW info_clientes_frecuentes2 as
SELECT c.*, r.* 
FROM usuario_cliente c JOIN reserva r ON c.idUsuario = r.idUsuarioCliente 
WHERE c.idUsuario IN (
    SELECT r2.idUsuarioCliente
    FROM reserva r2
    GROUP BY r2.idUsuarioCliente 
    HAVING COUNT(r2.idUsuarioCliente) > 3
)
