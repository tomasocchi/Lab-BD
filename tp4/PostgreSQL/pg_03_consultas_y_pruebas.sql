
SET search_path TO esquema_grupo1;

EXPLAIN ANALYZE
SELECT * FROM reserva_tabla2 WHERE idReserva = 250000;

EXPLAIN ANALYZE
SELECT * FROM reserva_tabla1
WHERE fechaInicio BETWEEN '2026-01-01' AND '2026-01-31';

EXPLAIN ANALYZE
SELECT * FROM reserva_tabla2
WHERE fechaInicio BETWEEN '2026-01-01' AND '2026-01-31';

EXPLAIN ANALYZE
SELECT * FROM reserva_tabla1
WHERE EXTRACT(YEAR FROM fechaInicio) = 2026
  AND EXTRACT(MONTH FROM fechaInicio) = 1;

DROP INDEX idx_tabla1_btree_id;
DROP INDEX idx_tabla1_btree_fecha;
DROP INDEX idx_tabla2_hash_id;
DROP INDEX idx_tabla2_hash_fecha;


SELECT tablename, indexname
FROM pg_indexes
WHERE schemaname = 'esquema_grupo1'
  AND tablename IN ('reserva_tabla1', 'reserva_tabla2');

-- Consulta 1.4.c 1
EXPLAIN ANALYZE SELECT * FROM reserva_tabla2 WHERE idReserva = 250000;

-- Consulta 1.4.c 2
EXPLAIN ANALYZE SELECT * FROM reserva_tabla1
WHERE fechaInicio BETWEEN '2026-01-01' AND '2026-01-31';

-- Consulta 1.4.d 1
EXPLAIN ANALYZE SELECT * FROM reserva_tabla2
WHERE fechaInicio BETWEEN '2026-01-01' AND '2026-01-31';

-- Consulta 1.4.d 2
EXPLAIN ANALYZE SELECT * FROM reserva_tabla1
WHERE EXTRACT(YEAR FROM fechaInicio) = 2026
  AND EXTRACT(MONTH FROM fechaInicio) = 1;
