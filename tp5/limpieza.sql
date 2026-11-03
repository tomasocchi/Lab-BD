/* nodo1 y nodo3 */
SELECT gid FROM pg_prepared_xacts;

/* nodo1 */
DROP TABLE public.aloja_dist;
DROP FOREIGN TABLE public.alojamiento_dist_s3;
DROP TABLE public.alojamiento_dist;
DROP SEQUENCE public.alojamiento_dist_seq;
DROP USER MAPPING FOR CURRENT_USER SERVER sitio_nodo3;
DROP SERVER sitio_nodo3;
DROP EXTENSION postgres_fdw;
DELETE FROM public.usuario_cliente WHERE nroDni BETWEEN 70000001 AND 70002000;
