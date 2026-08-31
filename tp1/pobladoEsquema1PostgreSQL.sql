INSERT INTO esquema_grupo1.Usuario_cliente
    (nroDni, tipoDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES
    (30111222, 'DNI', 'Lucía',    'Fernández', 'lucia@mail.com',   'San Martín 123', '1995-03-14'),
    (28555666, 'DNI', 'Martín',   'Gómez',     'martin@mail.com',  'Belgrano 456',   '1988-07-22'),
    (35222888, 'LC',  'Sofía',    'Ramírez',   'sofia@mail.com',   'Rivadavia 789',  '2000-11-05'),
    (40777999, 'PAS', 'Diego',    'Torres',    'diego@mail.com',   'Mitre 321',      '1992-01-30'),
    (32444555, 'CI',  'Valentina','López',     'valen@mail.com',   'Sarmiento 654',  '1998-09-18');


INSERT INTO esquema_grupo1.Usuario_Alojamiento
    (CUIT, nroDni, tipoDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES
    (20300111222, 27111333, 'DNI', 'Carlos',   'Pereyra', 'carlos@hoteles.com', 'Av. Colón 100',   '1980-05-12'),
    (20300222333, 29222444, 'DNI', 'Marina',   'Suárez',  'marina@hoteles.com', 'Av. Alem 200',    '1985-02-28'),
    (20300333444, 31333555, 'LC',  'Roberto',  'Aguirre', 'roberto@hoteles.com','Av. Argentina 300','1990-12-01'),
    (20300444555, 33444666, 'DNI', 'Gabriela', 'Molina',  'gabriela@hoteles.com','Av. Belgrano 400','1993-06-19'),
    (20300555666, 35555777, 'PAS', 'Esteban',  'Vera',    'esteban@hoteles.com','Av. Roca 500',    '1987-10-08');


INSERT INTO esquema_grupo1.Alojamiento
    (nombre, descripcionA, imagenes, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES
    ('Hotel Andes',        'Hotel boutique en el centro de la ciudad', 'andes1.jpg;andes2.jpg', 'San Martín',   200, 'Argentina', 'Neuquén',        40, 1),
    ('Cabaña del Bosque',  'Cabaña de montaña con vista al lago',      'cabania1.jpg',          'Ruta 40',      15,  'Argentina', 'San Martín de los Andes', 4, 2),
    ('Hotel Plaza',        'Hotel céntrico ideal para viajes de negocios', 'plaza1.jpg',        'Av. Argentina',350, 'Argentina', 'Neuquén',        60, 3),
    ('Depto Vista al Río', 'Departamento moderno frente al río',       'depto1.jpg;depto2.jpg', 'Costanera',    50,  'Argentina', 'Cipolletti',     2, 4),
    ('Hostal Sur',         'Hostal económico y familiar',              'hostal1.jpg',           'Belgrano',     120, 'Argentina', 'Bariloche',      20, 5);


INSERT INTO esquema_grupo1.Hotel
    (idAlojamiento, cantEstrellas)
VALUES
    (1, 4),
    (3, 5);


INSERT INTO esquema_grupo1.Particular
    (idAlojamiento, tipoParticular, aptoMascotas, cantBaños, capacidad, precioPorNoche)
VALUES
    (2, 'Cabaña',       TRUE,  1, 4, 45000),
    (4, 'Departamento', FALSE, 1, 3, 32000),
    (5, 'Hostal',       TRUE,  3, 8, 25000);

INSERT INTO esquema_grupo1.tipohabitacion (descripcion) VALUES
('Simple'),
('Doble'),
('Suite'),
('Twin'),
('Triple'),
('Cuadruple');

INSERT INTO esquema_grupo1.habitacion
    (idAlojamiento, nroHabitacion, idTipohabitacion, cantAmbientes, precioPorNoche, capacidad)
VALUES
    (1, 101, 2, 1, 32000, 2),
    (1, 102, 3, 2, 70000, 4),
    (1, 201, 5, 1, 45000, 3),
    (3, 301, 1, 1, 24000, 1),
    (3, 302, 4, 1, 28000, 2);


INSERT INTO esquema_grupo1.Mensajeria
    (idUsuarioCliente, idUsuarioAlojamiento)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);


INSERT INTO esquema_grupo1.Reserva
    (fechaInicio, fechaFin, cantPersonas, precioTotal, idUsuarioCliente, idMensajeria)
VALUES
    ('2026-09-10', '2026-09-15', 2, 175000, 1, 1),
    ('2026-10-01', '2026-10-05', 4, 180000,  2, 2),
    ('2026-09-20', '2026-09-22', 1, 60000,   3, 3),
    ('2026-11-05', '2026-11-10', 3, 160000,  4, 4),
    ('2026-12-24', '2026-12-28', 8, 100000,  5, 5);


INSERT INTO esquema_grupo1.Reserva_Hotel
    (idReserva, configuracionHabitacion)
VALUES
    (1, 'Una habitación doble, piso alto'),
    (3, 'Habitación suite con vista a la plaza');


INSERT INTO esquema_grupo1.Reserva_Particular
    (idReserva, idAlojamiento)
VALUES
    (2, 2),
    (4, 4),
    (5, 5);


INSERT INTO esquema_grupo1.Estado_Reserva
    (nombreEstado)
VALUES
    ('Pendiente'),
    ('Aceptada'),
    ('Confirmada'),
    ('Cancelada'),
    ('Rechazada');


INSERT INTO esquema_grupo1.Pago
    (señaPagada, totalPagado, idReserva)
VALUES
    (TRUE,  175000, 1),
    (FALSE, 0,      2),
    (TRUE,  60000,  3),
    (FALSE, 0,      4),
    (FALSE, 0,      5);


INSERT INTO esquema_grupo1.Reseña
    (calificacionGeneral)
VALUES
    (5),
    (4),
    (3),
    (5),
    (2);


INSERT INTO esquema_grupo1.Reseña_Cliente
    (idReseña, descripcion, idReserva)
VALUES
    (1, 'Excelente atención y habitación impecable', 1),
    (2, 'Buena ubicación, aunque el ruido molestó un poco', 2),
    (3, 'Todo correcto, volvería a alojarme', 3);


INSERT INTO esquema_grupo1.Reseña_Alojamiento
    (idReseña, idReserva)
VALUES
    (4, 4),
    (5, 5);


INSERT INTO esquema_grupo1.Item_Evaluado
    (calificacion, descripcion, tipoItem, idReseña)
VALUES
    (5, 'Cocina muy completa y limpia',        'COCINA',      1),
    (4, 'Baño amplio, faltó un poco de agua caliente', 'BANIO', 1),
    (5, 'Excelente limpieza general',          'LIMPIEZA',    2),
    (3, 'Un poco de ruido de la calle',        'RUIDO',       2),
    (4, 'Llegada puntual y sin inconvenientes', 'PUNTUALIDAD', 3);


INSERT INTO esquema_grupo1.asociadaAHabitacion
    (idReserva, idHabitacion, idAlojamiento)
VALUES
    (1, 2, 1),
    (3, 3, 1),
    (1, 4, 3);


INSERT INTO esquema_grupo1.registra
    (idReserva, idEstadoReserva, fechaEstado)
VALUES
    (1, 1, '2026-08-20'),
    (1, 3, '2026-08-22'),
    (2, 1, '2026-08-25'),
    (4, 4, '2026-08-27'),
    (5, 5, '2026-08-28');


INSERT INTO esquema_grupo1.listaMensajes
    (idMensaje, mensaje, idMensajeria)
VALUES
    (1, 'Hola, ¿la habitación tiene wifi?', 1),
    (2, 'Sí, wifi gratuito en todo el hotel.', 1),
    (1, '¿Aceptan mascotas?', 2),
    (2, 'Sí, sin cargo extra.', 2),
    (1, '¿A qué hora es el check-in?', 3);

