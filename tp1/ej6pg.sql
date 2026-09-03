-- creacion de tabla tipo
CREATE TABLE esquema_grupo1.tipoHabitacion(
	idTipo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
descripcion esquema_grupo1.ingresotexto
);

INSERT INTO esquema_grupo1.tipoHabitacion (descripcion) VALUES
('Simple'),
('Doble'),
('Suite'),
('Twin'),
('Triple'),
('Cuadruple');


--vinculo con habitacion
ALTER TABLE esquema_grupo1.habitacion
    DROP COLUMN tipoHabitacion;

ALTER TABLE esquema_grupo1.habitacion
    ADD COLUMN idTipoHabitacion INT NOT NULL DEFAULT 0,
    ADD FOREIGN KEY (idTipoHabitacion) REFERENCES esquema_grupo1.tipoHabitacion(idTipo)
        ON DELETE RESTRICT ON UPDATE CASCADE;

-- fecha_alta en usuario
ALTER TABLE esquema_grupo1.usuario_cliente
    ADD COLUMN fecha_alta DATE NOT NULL DEFAULT CURRENT_DATE;
