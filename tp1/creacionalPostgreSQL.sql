-- Primer Esquema 
CREATE TABLE esquema_grupo1.Usuario_cliente (
    idUsuario           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nroDni              INTEGER UNIQUE NOT NULL,
    tipoDni             esquema_grupo1.domtipodoc,
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(100),
    direccion           VARCHAR(20),
    fechaNacimiento     esquema_grupo1.edad NOT NULL
);
 
CREATE TABLE esquema_grupo1.Usuario_Alojamiento (
    idUsuario           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CUIT                BIGINT UNIQUE,
    nroDni              INTEGER UNIQUE NOT NULL,
    tipoDni             esquema_grupo1.domtipodoc,
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(100),
    direccion           VARCHAR(20),
    fechaNacimiento     esquema_grupo1.edad
);
 
CREATE TABLE esquema_grupo1.Alojamiento (
    idAlojamiento       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre              VARCHAR(20) NOT NULL,
    descripcionA        esquema_grupo1.ingresotexto,
    imagenes            VARCHAR(255),
    calle               VARCHAR(20) NOT NULL,
    numero              INTEGER NOT NULL,
    pais                VARCHAR(20),
    ciudad              VARCHAR(100),
    cantCamas           INTEGER,
    idUsuario           INTEGER,
    FOREIGN KEY (idUsuario) REFERENCES esquema_grupo1.Usuario_Alojamiento(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Hotel (
    idAlojamiento       INT PRIMARY KEY,
    cantEstrellas       INTEGER,
    FOREIGN KEY (idAlojamiento) REFERENCES esquema_grupo1.Alojamiento(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Particular (
    idAlojamiento       INT PRIMARY KEY,
    tipoParticular      VARCHAR(20),
    aptoMascotas        BOOLEAN,
    cantBaños           INTEGER,
    capacidad           INTEGER,
    precioPorNoche      INTEGER,
    FOREIGN KEY (idAlojamiento) REFERENCES esquema_grupo1.Alojamiento(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Habitacion (
    idHabitacion    INT GENERATED ALWAYS AS IDENTITY,
    idAlojamiento   INTEGER,
    nroHabitacion   INTEGER,
    tipoHabitacion  esquema_grupo1.domTipoHabitacion,
    cantAmbientes   INTEGER,
    precioPorNoche  esquema_grupo1.precioNoche,
    capacidad       INTEGER,
    PRIMARY KEY (idHabitacion, idAlojamiento),
    FOREIGN KEY (idAlojamiento) REFERENCES esquema_grupo1.Hotel(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Mensajeria (
    idMensajeria            INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idUsuarioCliente        INTEGER,
    idUsuarioAlojamiento    INTEGER,
    FOREIGN KEY (idUsuarioCliente) REFERENCES esquema_grupo1.Usuario_cliente(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idUsuarioAlojamiento) REFERENCES esquema_grupo1.Usuario_Alojamiento(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Reserva (
    idReserva           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fechaInicio         esquema_grupo1.inicioReserva,
    fechaFin            DATE NOT NULL,
    cantPersonas        INTEGER,
    precioTotal         INTEGER,
    idUsuarioCliente    INTEGER,
    idMensajeria        INTEGER,
    FOREIGN KEY (idUsuarioCliente) REFERENCES esquema_grupo1.Usuario_cliente(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idMensajeria) REFERENCES esquema_grupo1.Mensajeria(idMensajeria)
        ON DELETE SET NULL ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Reserva_Hotel (
    idReserva               INT PRIMARY KEY,
    configuracionHabitacion esquema_grupo1.ingresotexto,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Reserva_Particular (
    idReserva               INT PRIMARY KEY,
    idAlojamiento           INTEGER,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idAlojamiento) REFERENCES esquema_grupo1.Particular(idAlojamiento) ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Estado_Reserva (
    idEstadoReserva     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcionEstado   esquema_grupo1.domEstado
);
 
CREATE TABLE esquema_grupo1.Pago (
    idPago          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    señaPagada      esquema_grupo1.montopagado,
    totalPagado     INTEGER,
    idReserva       INTEGER,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1.Reserva(idReserva)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Reseña (
    idReseña                INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    calificacionGeneral     INTEGER
);
 
CREATE TABLE esquema_grupo1.Reseña_Cliente (
    idReseña        INT PRIMARY KEY,
    descripcion     esquema_grupo1.ingresotexto,
    idReserva       INTEGER,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idReseña) REFERENCES esquema_grupo1.Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Reseña_Alojamiento (
    idReseña    INT PRIMARY KEY,
    idReserva   INTEGER,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idReseña) REFERENCES esquema_grupo1.Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.Item_Evaluado (
    idItem          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    calificacion    INTEGER,
    descripcion     esquema_grupo1.ingresotexto,
    tipoItem        esquema_grupo1.domItemEvaluado,
    idReseña        INTEGER,
    FOREIGN KEY (idReseña) REFERENCES esquema_grupo1.Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.asociadaAHabitacion (
    idReserva       INTEGER,
    idHabitacion    INTEGER,
    idAlojamiento   INTEGER,
    PRIMARY KEY (idReserva, idHabitacion, idAlojamiento),
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idHabitacion, idAlojamiento) REFERENCES esquema_grupo1.Habitacion(idHabitacion, idAlojamiento)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1.registra (
    idReserva          INTEGER,
    idEstadoReserva    INTEGER,
    fechaEstado        DATE NOT NULL,
    PRIMARY KEY (idReserva, idEstadoReserva),
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idEstadoReserva) REFERENCES esquema_grupo1.Estado_Reserva(idEstadoReserva)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
 
CREATE TABLE esquema_grupo1.listaMensajes (
    idMensaje       INTEGER,
    idMensajeria    INTEGER,
    mensaje esquema_grupo1_alt.ingresotexto,
    PRIMARY KEY (idMensaje, idMensajeria),
    FOREIGN KEY (idMensajeria) REFERENCES esquema_grupo1.Mensajeria(idMensajeria)
        ON DELETE CASCADE ON UPDATE CASCADE
);



-- Segundo Esquema 
CREATE TABLE esquema_grupo1_alt.Usuario_cliente (
    idUsuario           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nroDni              INTEGER UNIQUE NOT NULL,
    tipoDni             esquema_grupo1_alt.domtipodoc,
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(100),
    direccion           VARCHAR(20),
    fechaNacimiento     esquema_grupo1_alt.edad NOT NULL
);
 
CREATE TABLE esquema_grupo1_alt.Usuario_Alojamiento (
    idUsuario           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CUIT                BIGINT UNIQUE,
    nroDni              INTEGER UNIQUE NOT NULL,
    tipoDni             esquema_grupo1_alt.domtipodoc,
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(100),
    direccion           VARCHAR(20),
    fechaNacimiento     esquema_grupo1_alt.edad
);
 
CREATE TABLE esquema_grupo1_alt.Alojamiento (
    idAlojamiento       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre              VARCHAR(20) NOT NULL,
    descripcionA        esquema_grupo1_alt.ingresotexto,
    imagenes            VARCHAR(255),
    calle               VARCHAR(20) NOT NULL,
    numero              INTEGER NOT NULL,
    pais                VARCHAR(20),
    ciudad              VARCHAR(100),
    cantCamas           INTEGER,
    idUsuario           INTEGER,
    FOREIGN KEY (idUsuario) REFERENCES esquema_grupo1_alt.Usuario_Alojamiento(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Hotel (
    idAlojamiento       INT PRIMARY KEY,
    cantEstrellas       INTEGER,
    FOREIGN KEY (idAlojamiento) REFERENCES esquema_grupo1_alt.Alojamiento(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Particular (
    idAlojamiento       INT PRIMARY KEY,
    tipoParticular      VARCHAR(20),
    aptoMascotas        BOOLEAN,
    cantBaños           INTEGER,
    capacidad           INTEGER,
    precioPorNoche      INTEGER,
    FOREIGN KEY (idAlojamiento) REFERENCES esquema_grupo1_alt.Alojamiento(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Habitacion (
    idHabitacion    INT GENERATED ALWAYS AS IDENTITY,
    idAlojamiento   INTEGER,
    nroHabitacion   INTEGER,
    tipoHabitacion  esquema_grupo1_alt.domTipoHabitacion,
    cantAmbientes   INTEGER,
    precioPorNoche  esquema_grupo1_alt.precioNoche,
    capacidad       INTEGER,
    PRIMARY KEY (idHabitacion, idAlojamiento),
    FOREIGN KEY (idAlojamiento) REFERENCES esquema_grupo1_alt.Hotel(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Mensajeria (
    idMensajeria            INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idUsuarioCliente        INTEGER,
    idUsuarioAlojamiento    INTEGER,
    FOREIGN KEY (idUsuarioCliente) REFERENCES esquema_grupo1_alt.Usuario_cliente(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idUsuarioAlojamiento) REFERENCES esquema_grupo1_alt.Usuario_Alojamiento(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Reserva (
    idReserva           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fechaInicio         esquema_grupo1_alt.inicioReserva,
    fechaFin            DATE NOT NULL,
    cantPersonas        INTEGER,
    precioTotal         INTEGER,
    estado              esquema_grupo1_alt.domEstado,
    idUsuarioCliente    INTEGER,
    idMensajeria        INTEGER,
    FOREIGN KEY (idUsuarioCliente) REFERENCES esquema_grupo1_alt.Usuario_cliente(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idMensajeria) REFERENCES esquema_grupo1_alt.Mensajeria(idMensajeria)
        ON DELETE SET NULL ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Reserva_Hotel (
    idReserva               INT PRIMARY KEY,
    configuracionHabitacion esquema_grupo1_alt.ingresotexto,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1_alt.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Reserva_Particular (
    idReserva               INT PRIMARY KEY,
    idAlojamiento           INTEGER,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1_alt.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idAlojamiento) REFERENCES esquema_grupo1_alt.Particular(idAlojamiento) ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Estado_Reserva (
    idEstadoReserva     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcionEstado   esquema_grupo1_alt.domestado
);
 
CREATE TABLE esquema_grupo1_alt.Pago (
    idPago          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    señaPagada      esquema_grupo1_alt.montopagado,
    totalPagado     INTEGER,
    idReserva       INTEGER,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1_alt.Reserva(idReserva)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Reseña (
    idReseña                INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    calificacionGeneral     INTEGER
);
 
CREATE TABLE esquema_grupo1_alt.Reseña_Cliente (
    idReseña        INT PRIMARY KEY,
    descripcion     esquema_grupo1_alt.ingresotexto,
    idReserva       INTEGER,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1_alt.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idReseña) REFERENCES esquema_grupo1_alt.Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Reseña_Alojamiento (
    idReseña    INT PRIMARY KEY,
    idReserva   INTEGER,
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1_alt.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idReseña) REFERENCES esquema_grupo1_alt.Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.Item_Evaluado (
    idItem          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    calificacion    INTEGER,
    descripcion     esquema_grupo1_alt.ingresotexto,
    tipoItem        esquema_grupo1_alt.domItemEvaluado,
    idReseña        INTEGER,
    FOREIGN KEY (idReseña) REFERENCES esquema_grupo1_alt.Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.asociadaAHabitacion (
    idReserva       INTEGER,
    idHabitacion    INTEGER,
    idAlojamiento   INTEGER,
    PRIMARY KEY (idReserva, idHabitacion, idAlojamiento),
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1_alt.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idHabitacion, idAlojamiento) REFERENCES esquema_grupo1_alt.Habitacion(idHabitacion, idAlojamiento)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
CREATE TABLE esquema_grupo1_alt.registra (
    idReserva          INTEGER,
    idEstadoReserva    INTEGER,
    fechaEstado        DATE NOT NULL,
    PRIMARY KEY (idReserva, idEstadoReserva),
    FOREIGN KEY (idReserva) REFERENCES esquema_grupo1_alt.Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idEstadoReserva) REFERENCES esquema_grupo1_alt.Estado_Reserva(idEstadoReserva)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
 
 
CREATE TABLE esquema_grupo1_alt.listaMensajes (
    idMensaje       INTEGER,
    idMensajeria    INTEGER,
    mensaje esquema_grupo1_alt.ingresotexto,
    PRIMARY KEY (idMensaje, idMensajeria),
    FOREIGN KEY (idMensajeria) REFERENCES esquema_grupo1_alt.Mensajeria(idMensajeria)
        ON DELETE CASCADE ON UPDATE CASCADE
);

