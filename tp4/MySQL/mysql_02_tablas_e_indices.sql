
SET SESSION max_heap_table_size = 268435456;

DROP TABLE IF EXISTS reserva_tabla2;
CREATE TABLE reserva_tabla2 LIKE reserva_tabla1;
ALTER TABLE reserva_tabla2 ENGINE=MEMORY;

CREATE INDEX idx_tabla2_hash_id    ON reserva_tabla2 (idReserva)   USING HASH;
CREATE INDEX idx_tabla2_hash_fecha ON reserva_tabla2 (fechaInicio) USING HASH;
CREATE INDEX idx_tabla1_btree_id    ON reserva_tabla1 (idReserva)   USING BTREE;
CREATE INDEX idx_tabla1_btree_fecha ON reserva_tabla1 (fechaInicio) USING BTREE;

-- Verificacion
SELECT table_name, engine
FROM information_schema.tables
WHERE table_schema = 'tp1_reservas'
  AND table_name IN ('reserva_tabla1', 'reserva_tabla2');

SELECT table_name, index_name, column_name, index_type
FROM information_schema.statistics
WHERE table_schema = 'tp1_reservas'
  AND table_name IN ('reserva_tabla1', 'reserva_tabla2');

INSERT INTO reserva_tabla2
SELECT * FROM reserva_tabla1;

-- Verificacion
SELECT 'tabla1' AS tabla, COUNT(*) FROM reserva_tabla1
UNION ALL
SELECT 'tabla2', COUNT(*) FROM reserva_tabla2;   -- 500000 y 500000
