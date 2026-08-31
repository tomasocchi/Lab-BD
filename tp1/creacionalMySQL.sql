
USE tp1_reservas;

CREATE TABLE Usuario_cliente (
    idUsuario           INT PRIMARY KEY AUTO_INCREMENT,
    nroDni              INT UNIQUE NOT NULL,
    tipoDni             VARCHAR(3) CHECK (tipoDni IN ('DNI', 'PAS', 'CI', 'LC')) NOT NULL DEFAULT 'DNI',
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(20),
    direccion           VARCHAR(20),
    fechaNacimiento     DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Usuario_Alojamiento (
    idUsuario           INT PRIMARY KEY AUTO_INCREMENT,
    CUIT                INT UNIQUE,
    nroDni              INT UNIQUE NOT NULL,
    tipoDni             VARCHAR(3) CHECK (tipoDni IN ('DNI', 'PAS', 'CI', 'LC')) NOT NULL DEFAULT 'DNI',
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correoElectronico   VARCHAR(20),
    direccion           VARCHAR(20),
    fechaNacimiento     DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Alojamiento (
    idAlojamiento       INT PRIMARY KEY AUTO_INCREMENT,
    nombre              VARCHAR(20) NOT NULL,
    descripcionA        VARCHAR(300) DEFAULT 'SIN DESCRIPCION',
    imagenes            VARCHAR(255),
    calle               VARCHAR(20) NOT NULL,
    numero              INT NOT NULL,
    pais                VARCHAR(20),
    ciudad              VARCHAR(100),
    cantCamas           INT,
    idUsuario           INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuario_Alojamiento(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Hotel (
    idAlojamiento       INT PRIMARY KEY,
    cantEstrellas       INT,
    FOREIGN KEY (idAlojamiento) REFERENCES Alojamiento(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Particular (
    idAlojamiento       INT PRIMARY KEY,
    tipoParticular      VARCHAR(20),
    aptoMascotas        BOOLEAN,
    cantBaños           INT,
    capacidad           INT,
    precioPorNoche      INT,
    FOREIGN KEY (idAlojamiento) REFERENCES Alojamiento(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Habitacion (
    idHabitacion    INT AUTO_INCREMENT,
    idAlojamiento   INT,
    nroHabitacion   INT,
    tipoHabitacion  VARCHAR(50) CHECK (tipoHabitacion IN ('Simple', 'Doble', 'Suite', 'Twin', 'Triple', 'Cuadruple')) NOT NULL DEFAULT 'Simple',
    cantAmbientes   INT,
    precioPorNoche  INT CHECK (precioPorNoche >= 20000) NOT NULL DEFAULT 20000,
    capacidad       INT,
    PRIMARY KEY (idHabitacion, idAlojamiento),
    FOREIGN KEY (idAlojamiento) REFERENCES Hotel(idAlojamiento)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Mensajeria (
    idMensajeria            INT PRIMARY KEY AUTO_INCREMENT,
    idUsuarioCliente        INT,
    idUsuarioAlojamiento    INT,
    FOREIGN KEY (idUsuarioCliente) REFERENCES Usuario_cliente(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idUsuarioAlojamiento) REFERENCES Usuario_Alojamiento(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Reserva (
    idReserva           INT PRIMARY KEY AUTO_INCREMENT,
    fechaInicio         DATE NOT NULL,
    fechaFin            DATE NOT NULL,
    cantPersonas        INT,
    precioTotal         INT,
    idUsuarioCliente    INT,
    idMensajeria        INT,
    FOREIGN KEY (idUsuarioCliente) REFERENCES Usuario_cliente(idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idMensajeria) REFERENCES Mensajeria(idMensajeria)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Reserva_Hotel (
    idReserva               INT PRIMARY KEY,
    configuracionHabitacion VARCHAR(300) DEFAULT 'SIN DESCRIPCION',
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Reserva_Particular (
    idReserva               INT PRIMARY KEY,
    idAlojamiento           INT,
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (idAlojamiento) REFERENCES Particular(idAlojamiento)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Estado_Reserva (
    idEstadoReserva     INT PRIMARY KEY AUTO_INCREMENT,
    descripcionEstado   VARCHAR(20) CHECK (descripcionEstado IN ('Pendiente', 'Aceptada', 'Confirmada', 'Rechazada', 'Cancelada')),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Pago (
    idPago          INT PRIMARY KEY AUTO_INCREMENT,
    señaPagada      BOOLEAN DEFAULT FALSE,
    totalPagado     DECIMAL(10,2),
    idReserva       INT,
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Reseña (
    idReseña                INT PRIMARY KEY AUTO_INCREMENT,
    calificacionGeneral     INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Reseña_Cliente (
    idReseña        INT PRIMARY KEY,
    descripcion     VARCHAR(300) DEFAULT 'SIN DESCRIPCION',
    idReserva       INT,
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idReseña) REFERENCES Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Reseña_Alojamiento (
    idReseña    INT PRIMARY KEY,
    idReserva   INT,
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idReseña) REFERENCES Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Item_Evaluado (
    idItem          INT PRIMARY KEY AUTO_INCREMENT,
    calificacion    INT,
    descripcion     VARCHAR(300) DEFAULT 'SIN DESCRIPCION',
    tipoItem        VARCHAR(20) CHECK (tipoItem IN ('COCINA', 'BANIO', 'LIVING', 'BALCON', 'LIMPIEZA', 'PUNTUALIDAD', 'RUIDO')),
    idReseña        INT,
    FOREIGN KEY (idReseña) REFERENCES Reseña(idReseña)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE asociadaAHabitacion (
    idReserva       INT,
    idHabitacion    INT,
    idAlojamiento   INT,
    PRIMARY KEY (idReserva, idHabitacion, idAlojamiento),
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idHabitacion, idAlojamiento) REFERENCES Habitacion(idHabitacion, idAlojamiento)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE registra (
    idReserva          INT,
    idEstadoReserva    INT,
    fechaEstado        DATE NOT NULL,
    PRIMARY KEY (idReserva, idEstadoReserva),
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idEstadoReserva) REFERENCES Estado_Reserva(idEstadoReserva)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE listaMensajes (
    idMensaje       INT,
    idMensajeria    INT,
    mensaje VARCHAR(300) DEFAULT 'sin descripcion',
    PRIMARY KEY (idMensaje, idMensajeria),
    FOREIGN KEY (idMensajeria) REFERENCES Mensajeria(idMensajeria)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


