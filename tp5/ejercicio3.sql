/* nodo3 */
ALTER TABLE public.alojamiento ALTER COLUMN idAlojamiento DROP IDENTITY;

/* nodo1 */
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER sitio_nodo3 FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'nodo3', dbname 'db-nodo3', port '5432');

CREATE USER MAPPING FOR CURRENT_USER SERVER sitio_nodo3
    OPTIONS (user 'postgres', password 'CLAVE_NODO3');

/* nodo1 */
CREATE SEQUENCE public.alojamiento_dist_seq START WITH 1000;

CREATE TABLE public.alojamiento_dist (
    idAlojamiento   INT NOT NULL DEFAULT nextval('public.alojamiento_dist_seq'),
    nombre          VARCHAR(20) NOT NULL,
    descripcionA    public.ingresotexto,
    imagenes        VARCHAR(255),
    calle           VARCHAR(20) NOT NULL,
    numero          INTEGER NOT NULL,
    pais            VARCHAR(20) NOT NULL,
    ciudad          VARCHAR(100) NOT NULL,
    cantCamas       INTEGER,
    idUsuario       INTEGER
) PARTITION BY LIST (ciudad);

CREATE TABLE public.alojamiento_dist_s1
    PARTITION OF public.alojamiento_dist DEFAULT;

CREATE FOREIGN TABLE public.alojamiento_dist_s3
    PARTITION OF public.alojamiento_dist
    FOR VALUES IN ('Salta', 'Jujuy', 'San Salvador de Jujuy', 'La Rioja', 'Santiago del Estero',
                   'Tucuman', 'Catamarca', 'Formosa', 'Resistencia')
    SERVER sitio_nodo3 OPTIONS (schema_name 'public', table_name 'alojamiento');

/* nodo1 */
INSERT INTO public.alojamiento_dist (nombre, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES ('Casa Lago',    'Mitre',    10, 'Argentina', 'Bariloche', 4, 1),
       ('Depto Centro', 'Alcorta',  55, 'Argentina', 'Neuquen',   2, 1),
       ('Hotel Norte',  'Belgrano', 18, 'Argentina', 'Salta',     6, 1),
       ('Casa Tilcara', 'Rivadavia', 7, 'Argentina', 'Jujuy',     3, 1);

SELECT tableoid::regclass AS fragmento, idAlojamiento, nombre, ciudad
FROM public.alojamiento_dist
ORDER BY idAlojamiento;

/* nodo3 */
SELECT idAlojamiento, nombre, ciudad FROM public.alojamiento ORDER BY idAlojamiento;

/* nodo1 */
EXPLAIN (VERBOSE, COSTS OFF)
SELECT nombre FROM public.alojamiento_dist WHERE ciudad = 'Salta';

EXPLAIN (VERBOSE, COSTS OFF)
SELECT nombre FROM public.alojamiento_dist;

/* nodo1 */
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, fechaNacimiento)
SELECT 70000000 + g, 'Cliente' || g, 'Prueba', DATE '1990-01-01'
FROM generate_series(1, 2000) g;

INSERT INTO public.alojamiento_dist (idAlojamiento, nombre, calle, numero, pais, ciudad, cantCamas, idUsuario)
SELECT 1004 + g, 'Alojamiento ' || g, 'Calle ' || g, g, 'Argentina',
       (ARRAY['Neuquen', 'Bariloche', 'Cipolletti', 'Plottier'])[1 + g % 4], 1 + g % 8, 1
FROM generate_series(1, 20000) g;

INSERT INTO public.alojamiento_dist (idAlojamiento, nombre, calle, numero, pais, ciudad, cantCamas, idUsuario)
SELECT 30000 + g, 'Alojamiento ' || g, 'Calle ' || g, g, 'Argentina',
       (ARRAY['Salta', 'Jujuy', 'San Salvador de Jujuy', 'La Rioja', 'Santiago del Estero',
              'Tucuman', 'Catamarca', 'Formosa', 'Resistencia'])[1 + g % 9], 1 + g % 8, 1
FROM generate_series(1, 20000) g;

CREATE TABLE public.aloja_dist (
    idAloja         INT PRIMARY KEY,
    fecha_inicio    DATE NOT NULL,
    idAlojamiento   INT NOT NULL,
    idUsuario       INT NOT NULL REFERENCES public.usuario_cliente(idUsuario)
);

WITH alojs AS (
    SELECT array_agg(idAlojamiento ORDER BY idAlojamiento) AS v FROM public.alojamiento_dist
), clientes AS (
    SELECT array_agg(idUsuario ORDER BY idUsuario) AS v FROM public.usuario_cliente WHERE nroDni >= 70000000
)
INSERT INTO public.aloja_dist (idAloja, fecha_inicio, idAlojamiento, idUsuario)
SELECT g, CURRENT_DATE + (g % 365),
       (alojs.v)[1 + (g * 7919) % cardinality(alojs.v)],
       (clientes.v)[1 + g % cardinality(clientes.v)]
FROM generate_series(1, 30000) g, alojs, clientes;

ANALYZE public.usuario_cliente;
ANALYZE public.aloja_dist;
ANALYZE public.alojamiento_dist_s1;

SELECT COUNT(*) AS reservas_sin_alojamiento
FROM public.aloja_dist a
WHERE NOT EXISTS (SELECT 1 FROM public.alojamiento_dist b WHERE b.idAlojamiento = a.idAlojamiento);

/* nodo1 */
EXPLAIN (ANALYZE, VERBOSE)
SELECT u.idUsuario, u.nombre, COUNT(DISTINCT b.idAlojamiento) AS cant_alojamientos
FROM public.usuario_cliente u
JOIN public.aloja_dist a ON a.idUsuario = u.idUsuario
JOIN public.alojamiento_dist b ON b.idAlojamiento = a.idAlojamiento
GROUP BY u.idUsuario, u.nombre
HAVING COUNT(DISTINCT b.idAlojamiento) > 1;

/* nodo1 */
EXPLAIN (ANALYZE, VERBOSE)
SELECT u.idUsuario, u.nombre, COUNT(DISTINCT b.idAlojamiento) AS cant_alojamientos
FROM public.usuario_cliente u
JOIN public.aloja_dist a ON a.idUsuario = u.idUsuario
JOIN public.alojamiento_dist b ON b.idAlojamiento = a.idAlojamiento
WHERE b.cantCamas >= 7
GROUP BY u.idUsuario, u.nombre
HAVING COUNT(DISTINCT b.idAlojamiento) > 1;

/* nodo1, ejecutar con psql */
EXPLAIN (ANALYZE, VERBOSE)
SELECT a.idAloja, a.fecha_inicio, b.nombre
FROM public.aloja_dist a
JOIN public.alojamiento_dist b ON b.idAlojamiento = a.idAlojamiento
WHERE a.fecha_inicio <= CURRENT_DATE + 2;

SELECT string_agg(DISTINCT idAlojamiento::text, ',') AS ids
FROM public.aloja_dist
WHERE fecha_inicio <= CURRENT_DATE + 2
\gset

EXPLAIN (ANALYZE, VERBOSE)
SELECT a.idAloja, a.fecha_inicio, b.nombre
FROM public.aloja_dist a
JOIN public.alojamiento_dist b ON b.idAlojamiento = a.idAlojamiento
WHERE a.fecha_inicio <= CURRENT_DATE + 2
  AND b.idAlojamiento IN (:ids);

/* nodo1 */
ALTER TABLE public.alojamiento_dist ADD PRIMARY KEY (idAlojamiento);

ALTER TABLE public.alojamiento_dist ADD PRIMARY KEY (idAlojamiento, ciudad);

ALTER TABLE public.aloja_dist ADD FOREIGN KEY (idAlojamiento) REFERENCES public.alojamiento_dist(idAlojamiento);

ALTER TABLE public.alojamiento_dist_s1 ADD PRIMARY KEY (idAlojamiento);

INSERT INTO public.alojamiento_dist (idAlojamiento, nombre, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES ((SELECT MIN(idAlojamiento) FROM public.alojamiento_dist_s3), 'Duplicado', 'Calle', 1, 'Argentina', 'Neuquen', 1, 1);

SELECT idAlojamiento, tableoid::regclass AS fragmento, nombre
FROM public.alojamiento_dist
WHERE idAlojamiento = (SELECT MIN(idAlojamiento) FROM public.alojamiento_dist_s3);

DELETE FROM public.alojamiento_dist_s1 WHERE nombre = 'Duplicado';
