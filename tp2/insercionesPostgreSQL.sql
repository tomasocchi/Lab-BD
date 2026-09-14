--------------------------------------- PostgreSQL ---------------------------------------  
--  Inserciones VistaLocal 

-- Una que cumpla una condición de fecha.
INSERT INTO VistaLocal (idReserva, idAlojamiento) VALUES (27, 6);

-- Otra que no la cumpla.
INSERT INTO VistaLocal (idReserva, idAlojamiento) VALUES (28, 6);


-- Inserciones VistaCascade

-- Una que cumpla una condición de fecha.
INSERT INTO VistaCascade (idReserva, idAlojamiento) VALUES (27, 6);

-- Otra que no la cumpla.
INSERT INTO VistaCascade (idReserva, idAlojamiento) VALUES (28, 6);



-- Insercion en vista con JOIN 
INSERT INTO esquema_grupo1.info_clientes_frecuentes (idusuario, nroDni, tipoDni, nombre, apellido, correoElectronico, direccion, fechaNacimiento, fecha_alta, fechaInicio, fechaFin, cantPersonas, precioTotal, idUsuarioCliente, idMensajeria) 
VALUES (4, 40777999, 'PAS', 'Diego', 'Torres', 'diego@mail.com', 'Mitre 123, Neuquén', '1995-04-12', CURRENT_DATE, '2026-10-01', '2026-10-05', 2, 150000, 6, 3)
