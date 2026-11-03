/* nodo1 */
ALTER TABLE public.usuario_cliente ADD COLUMN puntos INTEGER NOT NULL DEFAULT 0;

/* sesion A1, nodo1 */
BEGIN;
UPDATE public.usuario_cliente SET puntos = puntos + 1 WHERE idusuario = 16;

/* sesion B3, nodo3 */
BEGIN;
UPDATE public.alojamiento SET cantCamas = cantCamas + 1 WHERE idAlojamiento = 1003;

/* sesion A3, nodo3: queda esperando a B3 */
BEGIN;
UPDATE public.alojamiento SET cantCamas = cantCamas + 1 WHERE idAlojamiento = 1003;

/* sesion B1, nodo1: queda esperando a A1 */
BEGIN;
UPDATE public.usuario_cliente SET puntos = puntos + 1 WHERE idusuario = 16;

/* nodo1 y nodo3, desde otra sesion */
SELECT pid, pg_blocking_pids(pid) AS bloqueado_por, wait_event_type, left(query, 40) AS consulta
FROM pg_stat_activity WHERE wait_event_type = 'Lock';

SELECT pid, pg_blocking_pids(pid) AS bloqueado_por, wait_event_type, wait_event,
       clock_timestamp() - query_start AS espera, left(query, 40) AS consulta
FROM pg_stat_activity WHERE wait_event_type = 'Lock';

/* sesion B1, nodo1: cancelar el UPDATE pendiente y luego */
ROLLBACK;

/* sesion B3, nodo3 */
ROLLBACK;

/* sesion A1, nodo1 */
COMMIT;

/* sesion A3, nodo3 */
COMMIT;

/* nodo1 */
SELECT idusuario, puntos FROM public.usuario_cliente WHERE idusuario = 16;

/* nodo3 */
SELECT idAlojamiento, cantCamas FROM public.alojamiento WHERE idAlojamiento = 1003;
