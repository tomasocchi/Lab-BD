SELECT r.idUsuarioCliente,
       MIN(r.fechaInicio) AS primera_reserva,
       MAX(r.fechaInicio) AS ultima_reserva,
       diferencia_meses(MIN(r.fechaInicio), MAX(r.fechaInicio)) AS meses_como_cliente
FROM reserva r
GROUP BY r.idUsuarioCliente
HAVING COUNT(*) > 1
ORDER BY meses_como_cliente DESC;