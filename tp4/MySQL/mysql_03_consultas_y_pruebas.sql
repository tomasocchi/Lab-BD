
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
WHERE YEAR(fechaInicio) = 2026 AND MONTH(fechaInicio) = 1;


SET SESSION max_heap_table_size = 268435456;

DROP INDEX idx_tabla1_btree_id    ON reserva_tabla1;
DROP INDEX idx_tabla1_btree_fecha ON reserva_tabla1;
DROP INDEX idx_tabla2_hash_id     ON reserva_tabla2;
DROP INDEX idx_tabla2_hash_fecha  ON reserva_tabla2;

-- Verificacion: no debe devolver filas
SELECT table_name, index_name
FROM information_schema.statistics
WHERE table_schema = 'tp1_reservas'
  AND table_name IN ('reserva_tabla1', 'reserva_tabla2');

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
WHERE YEAR(fechaInicio) = 2026 AND MONTH(fechaInicio) = 1;
