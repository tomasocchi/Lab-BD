
SET search_path TO esquema_grupo1;

DROP TABLE IF EXISTS reserva_tabla1;

CREATE TABLE reserva_tabla1 (
  idReserva        INT,
  idUsuarioCliente INT,
  fechaInicio      DATE,
  fechaFin         DATE,
  cantPersonas     INT,
  precioTotal      NUMERIC(12,2)
);

SELECT setseed(0.42);

INSERT INTO reserva_tabla1
SELECT s.g,                                         
       1 + (random()*9999)::int,                   
       s.fi,                                        
       s.fi + (1 + (random()*14)::int),            
       1 + (random()*5)::int,                    
       round((20000 + random()*480000)::numeric, 2) 
FROM (SELECT g, DATE '2024-01-01' + (random()*1460)::int AS fi
      FROM generate_series(1, 500000) g) s;

-- Verificacion
SELECT COUNT(*) FROM reserva_tabla1;       -- debe dar 500000
SELECT * FROM reserva_tabla1 LIMIT 10;     -- valores variados
