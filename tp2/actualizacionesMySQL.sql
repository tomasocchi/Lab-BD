--------------------------------------- MySQL ---------------------------------------  

-- Actualizacion LOCAL CHECK OPTION

-- Una que cumpla la condición.
UPDATE VistaLocal2 SET idAlojamiento = 6 WHERE idReserva = 11 

-- Otra que no la cumpla.
UPDATE VistaLocal2 SET idAlojamiento = 4 WHERE idReserva = 11 


-- Actualizacion CASCADED CHECK OPTION

-- Una que cumpla la condición.
UPDATE VistaCascade2
SET idAlojamiento = 5
WHERE idReserva = 11;


-- Otra que no la cumpla.
UPDATE VistaCascade2
SET idAlojamiento = 4
WHERE idReserva = 11;


