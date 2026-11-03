CREATE DATABASE sitio1;
CREATE DATABASE sitio3;

CREATE TABLE sitio1.usuario_cliente (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nroDni INT UNIQUE NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    fechaNacimiento DATE NOT NULL
);

CREATE TABLE sitio1.alojamiento (
    idAlojamiento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    cantCamas INT NOT NULL DEFAULT 1 CHECK (cantCamas >= 1)
);

CREATE TABLE sitio1.aloja (
    idAloja INT AUTO_INCREMENT PRIMARY KEY,
    fecha_inicio DATE,
    idAlojamiento INT NOT NULL,
    idUsuario INT NOT NULL,
    FOREIGN KEY (idAlojamiento) REFERENCES sitio1.alojamiento(idAlojamiento),
    FOREIGN KEY (idUsuario) REFERENCES sitio1.usuario_cliente(idUsuario)
);

CREATE TABLE sitio3.alojamiento (
    idAlojamiento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
        CHECK (ciudad IN ('Salta', 'Jujuy', 'San Salvador de Jujuy', 'La Rioja',
                          'Santiago del Estero', 'Tucuman', 'Catamarca', 'Formosa', 'Resistencia')),
    cantCamas INT NOT NULL DEFAULT 1 CHECK (cantCamas >= 1)
);

SHOW TABLES FROM sitio1;
SHOW TABLES FROM sitio3;

START TRANSACTION;
INSERT INTO sitio1.usuario_cliente (nroDni, nombre, apellido, fechaNacimiento)
VALUES (41000500, 'Tomas', 'Ramirez', '2002-01-02');
SET @cli = LAST_INSERT_ID();
SAVEPOINT sp1;

INSERT INTO sitio1.alojamiento (nombre, ciudad, cantCamas)
VALUES ('Llao Llao', 'Neuquen', 50);
SET @aloj = LAST_INSERT_ID();
SAVEPOINT sp2;

INSERT INTO sitio1.aloja (fecha_inicio, idAlojamiento, idUsuario)
VALUES (CURDATE(), @aloj, @cli);

SELECT * FROM sitio1.usuario_cliente;
SELECT * FROM sitio1.alojamiento;
SELECT * FROM sitio1.aloja;

ROLLBACK TO SAVEPOINT sp1;

SELECT * FROM sitio1.usuario_cliente;
SELECT * FROM sitio1.alojamiento;
SELECT * FROM sitio1.aloja;

COMMIT;
SELECT * FROM sitio1.usuario_cliente;

START TRANSACTION;
INSERT INTO sitio1.usuario_cliente (nroDni, nombre, apellido, fechaNacimiento)
VALUES (41000500, 'Duplicado', 'Prueba', '2000-01-01');
INSERT INTO sitio1.usuario_cliente (nroDni, nombre, apellido, fechaNacimiento)
VALUES (41000501, 'Valido', 'Prueba', '2000-01-01');
COMMIT;
SELECT * FROM sitio1.usuario_cliente;

/* sesion 1, sitio1 */
XA START 'alta_xa', 's1';
INSERT INTO sitio1.usuario_cliente (nroDni, nombre, apellido, fechaNacimiento)
VALUES (41000239, 'Juan', 'Ortiz', '1994-12-08');
XA END 'alta_xa', 's1';
XA PREPARE 'alta_xa', 's1';

/* sesion 2, sitio3 */
XA START 'alta_xa', 's3';
INSERT INTO sitio3.alojamiento (nombre, ciudad, cantCamas)
VALUES ('Belgrano', 'Salta', 50);
XA END 'alta_xa', 's3';
XA PREPARE 'alta_xa', 's3';

XA RECOVER;

XA COMMIT 'alta_xa', 's1';
XA COMMIT 'alta_xa', 's3';

XA RECOVER;
SELECT * FROM sitio1.usuario_cliente WHERE nroDni = 41000239;
SELECT * FROM sitio3.alojamiento WHERE nombre = 'Belgrano';

/* sesion 1, sitio1 */
XA START 'alta_xa2', 's1';
INSERT INTO sitio1.usuario_cliente (nroDni, nombre, apellido, fechaNacimiento)
VALUES (20077361, 'Lucia', 'Fernandez', '2000-06-27');
XA END 'alta_xa2', 's1';
XA PREPARE 'alta_xa2', 's1';

/* sesion 2, sitio3: el INSERT viola el CHECK de ciudades */
XA START 'alta_xa2', 's3';
INSERT INTO sitio3.alojamiento (nombre, ciudad, cantCamas)
VALUES ('Hotel Central', 'Rosario', 200);
XA END 'alta_xa2', 's3';
XA ROLLBACK 'alta_xa2', 's3';

XA ROLLBACK 'alta_xa2', 's1';
XA RECOVER;
SELECT * FROM sitio1.usuario_cliente WHERE nroDni = 20077361;
SELECT * FROM sitio3.alojamiento WHERE nombre = 'Hotel Central';

SELECT ENGINE, SUPPORT, TRANSACTIONS, XA, SAVEPOINTS
FROM information_schema.ENGINES
WHERE ENGINE IN ('InnoDB', 'FEDERATED');
