INSERT INTO esquema_grupo1_alt.Usuario_cliente
    (nroDni, tipoDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES
    (33111444, 'DNI', 'Nicolás',  'Herrera', 'nico@mail.com',    'Av. Libertad 45', '1994-04-10'),
    (41222555, 'PAS', 'Camila',   'Ortiz',   'camila@mail.com',  'Yrigoyen 88',     '1990-08-02'),
    (36333666, 'CI',  'Federico', 'Silva',   'fede@mail.com',    'Roca 210',        '1997-12-25'),
    (29444777, 'LC',  'Julieta',  'Méndez',  'julieta@mail.com', 'Alberdi 77',      '1985-06-15'),
    (38555888, 'DNI', 'Tomás',    'Acosta',  'tomas@mail.com',   'Urquiza 505',     '1999-02-28');


INSERT INTO esquema_grupo1_alt.Usuario_Alojamiento
    (CUIT, nroDni, tipoDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento)
VALUES
    (20301111222, 26111444, 'DNI', 'Patricia',  'Núñez',   'patricia@anfitriones.com',  'Av. San Juan 12', '1978-03-01'),
    (20301222333, 28222555, 'DNI', 'Alejandro', 'Ríos',    'alejandro@anfitriones.com', 'Corrientes 340',  '1982-09-14'),
    (20301333444, 30333666, 'LC',  'Florencia', 'Castro',  'florencia@anfitriones.com', 'Mendoza 210',     '1989-11-20'),
    (20301444555, 32444777, 'DNI', 'Ignacio',   'Paredes', 'ignacio@anfitriones.com',   'Tucumán 150',     '1991-05-05'),
    (20301555666, 34555888, 'PAS', 'Rocío',     'Benítez', 'rocio@anfitriones.com',     'Jujuy 90',        '1994-07-19');


INSERT INTO esquema_grupo1_alt.Alojamiento
    (nombre, descripcionA, imagenes, calle, numero, pais, ciudad, cantCamas, idUsuario)
VALUES
    ('Hotel Patagonia',  'Hotel de montaña con spa y vista al lago', 'patagonia1.jpg',    'Av. San Juan', 12,  'Argentina', 'Bariloche',                 50, 1),
    ('Loft Céntrico',    'Loft moderno en pleno centro porteño',     'loft1.jpg',         'Corrientes',   340, 'Argentina', 'Buenos Aires',               2, 2),
    ('Hotel Río Grande', 'Hotel familiar a pocas cuadras de la playa','riogrande1.jpg',   'Mendoza',      210, 'Argentina', 'Mar del Plata',             45, 3),
    ('Casa de Campo',    'Casa rural con pileta y parque amplio',    'campo1.jpg',        'Tucumán',      150, 'Argentina', 'Villa General Belgrano',   10, 4),
    ('Hostal Norte',     'Hostal juvenil y económico en el centro',  'hostalnorte1.jpg',  'Jujuy',        90,  'Argentina', 'Salta',                     30, 5);


INSERT INTO esquema_grupo1_alt.Hotel
    (idAlojamiento, cantEstrellas)
VALUES
    (1, 5),
    (3, 3);


INSERT INTO esquema_grupo1_alt.Particular
    (idAlojamiento, tipoParticular, aptoMascotas, cantBaños, capacidad, precioPorNoche)
VALUES
    (2, 'Loft',   FALSE, 1, 2,  40000),
    (4, 'Casa',   TRUE,  2, 6,  55000),
    (5, 'Hostal', TRUE,  4, 10, 22000);


INSERT INTO esquema_grupo1_alt.tipohabitacion (descripcion) VALUES
('Simple'),
('Doble'),
('Suite'),
('Twin'),
('Triple'),
('Cuadruple');


INSERT INTO esquema_grupo1_alt.Habitacion
    (idAlojamiento, nroHabitacion, idTipoHabitacion, cantAmbientes, precioPorNoche, capacidad)
VALUES
    (1, 101, 2, 1, 32000, 2),
    (1, 102, 3, 2, 70000, 4),
    (1, 201, 5, 1, 45000, 3),
    (3, 301, 1, 1, 24000, 1),
    (3, 302, 4, 1, 28000, 2);


INSERT INTO esquema_grupo1_alt.Mensajeria
    (idUsuarioCliente, idUsuarioAlojamiento)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);


INSERT INTO esquema_grupo1_alt.Reserva
    (fechaInicio, fechaFin, cantPersonas, precioTotal, idUsuarioCliente, idMensajeria)
VALUES
    ('2026-09-15', '2026-09-20', 2, 200000, 1, 1),
    ('2026-10-10', '2026-10-12', 1, 80000,   2, 2),
    ('2026-09-25', '2026-09-28', 4, 135000,   3, 3),
    ('2026-12-01', '2026-12-05', 5, 220000,  4, 4),
    ('2026-11-15', '2026-11-18', 3, 66000, 5, 5);


INSERT INTO esquema_grupo1_alt.Reserva_Hotel
    (idReserva, configuracionHabitacion)
VALUES
    (1, 'Habitación suite con desayuno incluido'),
    (3, 'Habitación triple con vista al mar');


INSERT INTO esquema_grupo1_alt.Reserva_Particular
    (idReserva, idAlojamiento)
VALUES
    (2, 2),
    (4, 4),
    (5, 5);


INSERT INTO esquema_grupo1_alt.Estado_Reserva
    (nombreEstado)
VALUES
    ('Confirmada'),
    ('Pendiente'),
    ('Aceptada'),
    ('Cancelada'),
    ('Rechazada');


INSERT INTO esquema_grupo1_alt.Pago
    (señaPagada, totalPagado, idReserva)
VALUES
    (TRUE,  200000, 1),
    (FALSE, 0,      2),
    (TRUE,  135000, 3),
    (FALSE, 0,      4),
    (FALSE, 0,      5);


INSERT INTO esquema_grupo1_alt.Reseña
    (calificacionGeneral)
VALUES
    (5),
    (3),
    (4),
    (2),
    (5);

INSERT INTO esquema_grupo1_alt.Reseña_Cliente
    (idReseña, descripcion, idReserva)
VALUES
    (1, 'Habitación impecable, superó expectativas', 1),
    (2, 'La ubicación fue buena pero tardaron en responder', 2),
    (3, 'Buena relación precio-calidad', 3);

INSERT INTO esquema_grupo1_alt.Reseña_Alojamiento
    (idReseña, idReserva)
VALUES
    (4, 4),
    (5, 5);

INSERT INTO esquema_grupo1_alt.Item_Evaluado
    (calificacion, descripcion, tipoItem, idReseña)
VALUES
    (5, 'Living muy cómodo y luminoso',       'LIVING',      1),
    (4, 'Balcón con buena vista',             'BALCON',      1),
    (3, 'Podría mejorar la limpieza',         'LIMPIEZA',    2),
    (2, 'Bastante ruido durante la noche',    'RUIDO',       2),
    (5, 'Muy puntuales en el check-in',       'PUNTUALIDAD', 3);


INSERT INTO esquema_grupo1_alt.asociadaAHabitacion
    (idReserva, idHabitacion, idAlojamiento)
VALUES
    (1, 1, 1),
    (1, 2, 1),
    (3, 4, 3);


INSERT INTO esquema_grupo1_alt.registra
    (idReserva, idEstadoReserva, fechaEstado)
VALUES
    (1, 1, '2026-08-25'),
    (1, 3, '2026-08-27'),
    (2, 1, '2026-08-28'),
    (4, 4, '2026-08-29'),
    (5, 5, '2026-08-30');


INSERT INTO esquema_grupo1_alt.listaMensajes
    (idMensaje, mensaje, idMensajeria)
VALUES
    (1, 'Hola, ¿tienen habitaciones disponibles para esas fechas?', 1),
    (2, 'Sí, tenemos disponibilidad.',                              1),
    (1, '¿El loft tiene cochera?',                                  2),
    (1, '¿Se puede pagar en cuotas?',                               3),
    (2, 'Sí, aceptamos tarjeta en 3 cuotas.',                       3);

