
DROP TABLE IF EXISTS reserva_tabla1;

CREATE TABLE reserva_tabla1 (
  idReserva        INT,
  idUsuarioCliente INT,
  fechaInicio      DATE,
  fechaFin         DATE,
  cantPersonas     INT,
  precioTotal      DECIMAL(12,2)
) ENGINE=InnoDB;

SET SESSION cte_max_recursion_depth = 500000;

INSERT INTO reserva_tabla1
WITH RECURSIVE seq (n) AS (
  SELECT 1 UNION ALL SELECT n + 1 FROM seq WHERE n < 500000
)
SELECT n,                                                     
       1 + (n * 13) MOD 10000,                                 
       DATE_ADD('2024-01-01', INTERVAL (n * 7) MOD 1461 DAY),  
       DATE_ADD('2024-01-01', INTERVAL ((n * 7) MOD 1461) + 1 + (n MOD 15) DAY), 
       1 + (n MOD 6),                                         
       ROUND(20000 + RAND(5) * 480000, 2)                     
FROM seq;

-- Verificacion
SELECT COUNT(*) FROM reserva_tabla1;       -- debe dar 500000
SELECT * FROM reserva_tabla1 LIMIT 10;     -- valores variados
