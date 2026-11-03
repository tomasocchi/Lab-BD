/* nodo1 */
BEGIN;
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (41000240, 'Marta', 'Suarez', 'marta@mail.com', 'Belgrano 12', '1990-05-20');
PREPARE TRANSACTION 'alta_pendiente';

/* nodo3 */
BEGIN;
INSERT INTO public.alojamiento (idAlojamiento, nombre, descripcionA, imagenes, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES (60001, 'Posada Jujuy', 'Posada en Jujuy', 'posada.jpg', 'Lavalle', 25, 'Argentina', 'Jujuy', 20, 1);
PREPARE TRANSACTION 'alta_pendiente';

/* nodo1 y nodo3 */
SELECT * FROM pg_prepared_xacts;

/* ejercicio4.sh: caida nodo3 */

/* nodo1 */
SELECT * FROM public.alojamiento_dist;

/* nodo1, otra sesion: queda esperando a la transaccion preparada */
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (41000240, 'Otra sesion', 'Prueba', 'prueba@mail.com', 'Calle 1', '1990-01-01');

/* nodo1 */
SELECT locktype, relation::regclass, mode, granted, pid
FROM pg_locks WHERE pid IS NULL;

/* ejercicio4.sh: iniciar nodo3 */

/* nodo3 */
SELECT * FROM pg_prepared_xacts;
SELECT * FROM public.alojamiento WHERE nombre = 'Posada Jujuy';

/* nodo1 y nodo3 */
COMMIT PREPARED 'alta_pendiente';
SELECT * FROM pg_prepared_xacts;

/* nodo1 y nodo2 */
SELECT * FROM public.usuario_cliente WHERE nroDni = 41000240;

/* nodo3 */
SELECT * FROM public.alojamiento WHERE nombre = 'Posada Jujuy';

/* nodo1 */
SELECT locktype, relation::regclass, mode, granted, pid FROM pg_locks WHERE pid IS NULL;

/* nodo1 */
BEGIN;
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (41000260, 'Carla', 'Diaz', 'carla@mail.com', 'Sarmiento 33', '1993-03-03');
PREPARE TRANSACTION 'alta_nodo2';

/* nodo3 */
BEGIN;
INSERT INTO public.alojamiento (idAlojamiento, nombre, descripcionA, imagenes, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES (60002, 'Posada Salta', 'Posada en Salta', 'posadas.jpg', 'Lavalle', 30, 'Argentina', 'Salta', 15, 1);
PREPARE TRANSACTION 'alta_nodo2';

/* ejercicio4.sh: caida nodo2 */

/* nodo1 */
SELECT * FROM pg_stat_replication;

INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (41000261, 'Dario', 'Paz', 'dario@mail.com', 'Mitre 5', '1992-02-02');

SELECT * FROM public.alojamiento_dist;

/* ejercicio4.sh: iniciar nodo2 */

/* nodo1 y nodo3 */
COMMIT PREPARED 'alta_nodo2';
SELECT * FROM pg_prepared_xacts;

/* nodo1 y nodo2 */
SELECT nroDni, nombre FROM public.usuario_cliente WHERE nroDni IN (41000260, 41000261);

/* nodo3 */
SELECT * FROM public.alojamiento WHERE nombre = 'Posada Salta';
