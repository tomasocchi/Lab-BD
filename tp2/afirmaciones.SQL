
-- Afirmacion 1
CREATE ASSERTION dependenciaHotel 
CHECK(
    NOT EXISTS (
        SELECT * 
        FROM hotel 
        WHERE idAlojamiento 
        NOT IN (
            SELECT idAlojamiento 
            FROM habitacion)
    )
);

-- consulta base equivalente
SELECT * 
FROM hotel 
WHERE idAlojamiento NOT IN (
                                                   SELECT idAlojamiento 
                                                   FROM habitacion)



-- Afirmacion 2
CREATE ASSERTION restriccionReservas 
CHECK (
    10 >= ALL (
        SELECT COUNT(idReserva) 
        FROM usuario_cliente u INNER JOIN reserva r ON u.idUsuario=r.idUsuarioCliente 
        GROUP BY u.idUsuario, EXTRACT(YEAR FROM(fechaInicio))
    )
) 

-- Consulta base equivalente
SELECT u.idUsuario, YEAR(r.fechaInicio) AS anio, COUNT(r.idReserva) AS cant_reservas
FROM Usuario_cliente u
INNER JOIN Reserva r ON u.idUsuario = r.idUsuarioCliente
GROUP BY u.idUsuario, YEAR(r.fechaInicio)
HAVING COUNT(r.idReserva) > 10;
