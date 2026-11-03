/* nodo1 */
ALTER TABLE public.aloja ALTER COLUMN idAloja ADD GENERATED ALWAYS AS IDENTITY;

/* nodo1 */
INSERT INTO public.usuario_alojamiento (CUIT, nroDni, tipoDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (20300555001, 30555001, 'DNI', 'Lucas', 'Gomez', 'lucas@mail.com', 'Mitre 10', '1985-03-03');

BEGIN;

INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (41000238, 'Tomas', 'Ramirez', 'tomasramirez@mail.com', 'Roca 99', '2002-01-02');
SAVEPOINT sp1;

INSERT INTO public.alojamiento (nombre, descripcionA, imagenes, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES ('Llao Llao', 'Hotel Bariloche', 'llaollao.jpg', 'Av. Bustillo', 340, 'Argentina', 'Neuquen', 50,
        (SELECT idUsuario FROM public.usuario_alojamiento WHERE nroDni = 30555001));
SAVEPOINT sp2;

INSERT INTO public.aloja (fecha_inicio, idAlojamiento, idUsuario)
VALUES (CURRENT_DATE,
        currval(pg_get_serial_sequence('public.alojamiento', 'idalojamiento')),
        (SELECT idUsuario FROM public.usuario_cliente WHERE nroDni = 41000238));

SELECT * FROM public.usuario_cliente WHERE nroDni = 41000238;
SELECT * FROM public.alojamiento WHERE nombre = 'Llao Llao';
SELECT * FROM public.aloja;

ROLLBACK TO SAVEPOINT sp1;

SELECT * FROM public.usuario_cliente WHERE nroDni = 41000238;
SELECT * FROM public.alojamiento WHERE nombre = 'Llao Llao';
SELECT * FROM public.aloja;

COMMIT;

/* nodo1 y nodo2 */
SELECT * FROM public.usuario_cliente WHERE nroDni = 41000238;
SELECT * FROM public.alojamiento WHERE nombre = 'Llao Llao';
SELECT * FROM public.aloja;

/* nodo3, base db-nodo3 */
CREATE DOMAIN domtipodoc AS VARCHAR(3)
    CHECK (VALUE IN ('DNI', 'PAS', 'CI', 'LC'))
    NOT NULL DEFAULT 'DNI';

CREATE DOMAIN ingresotexto AS VARCHAR(300)
    DEFAULT 'SIN DESCRIPCION';

CREATE DOMAIN edad AS DATE
    CHECK (EXTRACT(YEAR FROM AGE(CURRENT_DATE, VALUE)) >= 21);

CREATE DOMAIN ciudad_norte AS VARCHAR(100) NOT NULL
    CHECK (VALUE IN ('Salta', 'Jujuy', 'San Salvador de Jujuy', 'La Rioja', 'Santiago del Estero',
                     'Tucuman', 'Catamarca', 'Formosa', 'Resistencia'));

CREATE TABLE public.usuario_alojamiento (
    idUsuario           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CUIT                BIGINT UNIQUE,
    nroDni              INTEGER UNIQUE NOT NULL,
    tipoDni             public.domtipodoc,
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(100),
    direccion           VARCHAR(20),
    fechaNacimiento     public.edad
);

CREATE TABLE public.alojamiento (
    idAlojamiento       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre              VARCHAR(20) NOT NULL,
    descripcionA        public.ingresotexto,
    imagenes            VARCHAR(255),
    calle               VARCHAR(20) NOT NULL,
    numero              INTEGER NOT NULL,
    pais                VARCHAR(20) NOT NULL,
    ciudad              public.ciudad_norte,
    cantCamas           INTEGER,
    idUsuario           INTEGER,
    FOREIGN KEY (idUsuario) REFERENCES public.usuario_alojamiento(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO public.usuario_alojamiento (CUIT, nroDni, tipoDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (20300555001, 30555001, 'DNI', 'Lucas', 'Gomez', 'lucas@mail.com', 'Mitre 10', '1985-03-03');

/* nodo1 */
BEGIN;
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (41000239, 'Juan', 'Ortiz', 'juano15@mail.com', 'Canada 40', '1994-12-08');
PREPARE TRANSACTION 'alta_prueba';

/* nodo3 */
BEGIN;
INSERT INTO public.alojamiento (nombre, descripcionA, imagenes, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES ('Belgrano', 'Salta apart', 'hotelb.jpg', 'Las Lilas', 18, 'Argentina', 'Salta', 50, 1);
PREPARE TRANSACTION 'alta_prueba';

/* nodo1 y nodo3 */
SELECT * FROM pg_prepared_xacts;

/* nodo1 y nodo3 */
COMMIT PREPARED 'alta_prueba';
SELECT * FROM pg_prepared_xacts;

/* nodo1 y nodo2 */
SELECT * FROM public.usuario_cliente WHERE nroDni = 41000239;

/* nodo3 */
SELECT * FROM public.alojamiento WHERE nombre = 'Belgrano';

/* nodo1 */
BEGIN;
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (20077361, 'Lucia', 'Fernandez', 'lucifer@mail.com', 'Veron 280', '2000-06-27');
PREPARE TRANSACTION 'alta_prueba2';

/* nodo3: el INSERT viola el CHECK del dominio ciudad_norte */
BEGIN;
INSERT INTO public.alojamiento (nombre, descripcionA, imagenes, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES ('Hotel Central', 'Central', 'central.jpg', 'Rosario Central', 477, 'Argentina', 'Rosario', 200, 1);
ROLLBACK;

/* nodo1 */
ROLLBACK PREPARED 'alta_prueba2';
SELECT * FROM pg_prepared_xacts;
SELECT * FROM public.usuario_cliente WHERE nroDni = 20077361;

/* nodo3 */
SELECT * FROM public.alojamiento WHERE nombre = 'Hotel Central';
