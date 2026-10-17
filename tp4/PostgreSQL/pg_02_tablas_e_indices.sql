SET search_path TO esquema_grupo1;

DROP TABLE IF EXISTS reserva_tabla2;
CREATE TABLE reserva_tabla2 (LIKE reserva_tabla1);

CREATE INDEX idx_tabla1_btree_id    ON reserva_tabla1 USING btree (idReserva);
CREATE INDEX idx_tabla1_btree_fecha ON reserva_tabla1 USING btree (fechaInicio);
CREATE INDEX idx_tabla2_hash_id     ON reserva_tabla2 USING hash (idReserva);
CREATE INDEX idx_tabla2_hash_fecha  ON reserva_tabla2 USING hash (fechaInicio);

-- Verificacion
SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'esquema_grupo1'
  AND tablename IN ('reserva_tabla1', 'reserva_tabla2');


INSERT INTO reserva_tabla2
SELECT * FROM reserva_tabla1;


ANALYZE reserva_tabla1;
ANALYZE reserva_tabla2;

-- Verificacion
SELECT 'tabla1' AS tabla, COUNT(*) FROM reserva_tabla1
UNION ALL
SELECT 'tabla2', COUNT(*) FROM reserva_tabla2;   -- 500000 y 500000
