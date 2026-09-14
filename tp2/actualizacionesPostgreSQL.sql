--------------------------------------- PostgreSQL ---------------------------------------  


-- Actualizacion LOCAL CHECK OPTION

-- Una que cumpla la condición.
UPDATE esquema_grupo1.vistalocal2
SET idReserva = 21
WHERE idReserva = 24

-- Otra que no la cumpla.
UPDATE esquema_grupo1.VistaLocal2
SET idReserva = 19
WHERE idReserva = 27;


-- Actualizacion CASCADED CHECK OPTION

-- Una que cumpla la condición.
UPDATE esquema_grupo1.VistaCascade2
SET idReserva = 21
WHERE idReserva = 24;

-- Otra que no la cumpla.
UPDATE esquema_grupo1.VistaCascade2
SET idReserva = 19
WHERE idReserva = 27;
