/* ejercicio1.sh: entorno */

/* nodo1, base db-nodo1 */
CREATE DOMAIN domtipodoc AS VARCHAR(3)
    CHECK (VALUE IN ('DNI', 'PAS', 'CI', 'LC'))
    NOT NULL DEFAULT 'DNI';

CREATE DOMAIN ingresotexto AS VARCHAR(300)
    DEFAULT 'SIN DESCRIPCION';

CREATE DOMAIN precioNoche AS INTEGER
    CHECK (VALUE >= 20000)
    NOT NULL DEFAULT 20000;

CREATE DOMAIN inicioReserva AS DATE
    CHECK (VALUE >= CURRENT_DATE);

CREATE DOMAIN edad AS DATE
    CHECK (EXTRACT(YEAR FROM AGE(CURRENT_DATE, VALUE)) >= 21);

CREATE TABLE Usuario_cliente (
    idUsuario           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nroDni              INTEGER UNIQUE NOT NULL,
    tipoDni             domtipodoc,
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(100),
    direccion           VARCHAR(20),
    fechaNacimiento     edad NOT NULL,
    fecha_alta          DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE Usuario_Alojamiento (
    idUsuario           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CUIT                BIGINT UNIQUE,
    nroDni              INTEGER UNIQUE NOT NULL,
    tipoDni             domtipodoc,
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(100),
    direccion           VARCHAR(20),
    fechaNacimiento     edad
);

CREATE TABLE Alojamiento (
    idAlojamiento       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre              VARCHAR(20) NOT NULL,
    descripcionA        ingresotexto,
    imagenes            VARCHAR(255),
    calle               VARCHAR(20) NOT NULL,
    numero              INTEGER NOT NULL,
    pais                VARCHAR(20),
    ciudad              VARCHAR(100),
    cantCamas           INTEGER NOT NULL DEFAULT 1 CHECK (cantCamas >= 1),
    idUsuario           INTEGER,
    FOREIGN KEY (idUsuario) REFERENCES Usuario_Alojamiento(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Particular (
    idAlojamiento       INT PRIMARY KEY,
    tipoParticular      VARCHAR(20),
    aptoMascotas        BOOLEAN,
    cantBaños           INTEGER,
    capacidad           INTEGER,
    precioPorNoche      INTEGER NOT NULL DEFAULT 5000 CHECK (precioPorNoche >= 5000),
    FOREIGN KEY (idAlojamiento) REFERENCES Alojamiento(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Aloja (
    idAloja         INT PRIMARY KEY,
    fecha_inicio    inicioReserva,
    idAlojamiento   INT NOT NULL,
    idUsuario       INT NOT NULL,
    FOREIGN KEY (idAlojamiento) REFERENCES Alojamiento(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES Usuario_cliente(idUsuario)
        ON DELETE CASCADE ON UPDATE CASCADE
);

/* ejercicio1.sh: replicacion */

/* nodo1 */
SELECT client_addr, state, sync_state FROM pg_stat_replication;
SHOW synchronous_standby_names;

/* nodo2 */
SELECT pg_is_in_recovery();

/* nodo1 */
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (41000001, 'Franco', 'Gutierrez', 'franco@mail.com', 'Roca 99', '1996-04-04');

/* nodo2 */
SELECT * FROM public.usuario_cliente WHERE nroDni = 41000001;

/* nodo2: falla por ser solo lectura */
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES (41000234, 'Camila', 'Lopez', 'camila@mail.com', 'Roca 99', '1996-04-04');

/* ejercicio1.sh: detener nodo2 */

/* nodo1 */
INSERT INTO public.usuario_cliente (nroDni, nombre, apellido, fechaNacimiento)
VALUES (41000003, 'Hugo', 'Rodriguez', '1994-01-01'),
       (41000004, 'Ines', 'Juarez', '1993-02-02'),
       (41000005, 'Joel', 'Quintana', '1991-03-03');

SELECT COUNT(*) FROM public.usuario_cliente;

/* ejercicio1.sh: iniciar nodo2 */

/* nodo2 */
SELECT COUNT(*) FROM public.usuario_cliente;
