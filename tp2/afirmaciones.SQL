
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
SELECT COUNT(idReserva) 
FROM usuarioCliente u INNER JOIN reserva r ON u.idUsuario=r.idUsuario_Cliente 
GROUP BY u.idUsuario, EXTRACT(YEAR FROM(fechaInicio)) 
