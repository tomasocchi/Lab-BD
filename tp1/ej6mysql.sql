USE tp1_reservas;

-- creacion de tabla tipo
CREATE TABLE tipo_habitacion (
    idTipo      INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tipo_habitacion (idTipo, descripcion) VALUES
(1, 'Simple'),
(2, 'Doble'),
(3, 'Suite'),
(4, 'Twin'),
(5, 'Triple'),
(6, 'Cuadruple');

-- vinculacion con habitacion
ALTER TABLE Habitacion
    DROP COLUMN tipoHabitacion;

ALTER TABLE Habitacion
    ADD COLUMN idTipo INT NOT NULL DEFAULT 1,
    ADD CONSTRAINT fk_habitacion_tipo
        FOREIGN KEY (idTipo) REFERENCES tipo_habitacion(idTipo)
        ON DELETE RESTRICT ON UPDATE CASCADE;

-- fecha alta en usuario
ALTER TABLE Usuario_cliente
    ADD COLUMN fecha_alta DATE NOT NULL DEFAULT (CURRENT_DATE);
