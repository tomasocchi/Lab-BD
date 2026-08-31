-- primer esquema
CREATE DOMAIN esquema_grupo1.domtipodoc AS VARCHAR(3)
   CHECK (VALUE IN ('DNI', 'PAS', 'CI', 'LC'))
   NOT NULL DEFAULT 'DNI';
 
CREATE DOMAIN esquema_grupo1.domTipoHabitacion AS VARCHAR(20)
   CHECK (VALUE IN ('Simple', 'Doble', 'Suite', 'Twin', 'Triple', 'Cuadruple'))
   NOT NULL DEFAULT 'Simple';
 
CREATE DOMAIN esquema_grupo1.domItemEvaluado AS VARCHAR(20)
   CHECK (VALUE IN ('COCINA', 'BANIO', 'LIVING', 'BALCON', 'LIMPIEZA', 'PUNTUALIDAD', 'RUIDO'));
 
CREATE DOMAIN esquema_grupo1.ingresotexto AS VARCHAR(300)
   DEFAULT 'SIN DESCRIPCION';
 
CREATE DOMAIN esquema_grupo1.precioNoche AS INTEGER
   CHECK (VALUE >= 20000)
   NOT NULL DEFAULT 20000;
 
CREATE DOMAIN esquema_grupo1.domEstado AS VARCHAR(20)
   CHECK (VALUE IN ('Pendiente', 'Aceptada', 'Confirmada', 'Rechazada', 'Cancelada'));
 
CREATE DOMAIN esquema_grupo1.montopagado AS BOOLEAN
   DEFAULT FALSE;
 
CREATE DOMAIN esquema_grupo1.inicioReserva AS DATE
   CHECK (VALUE >= CURRENT_DATE);
 
CREATE DOMAIN esquema_grupo1.edad AS DATE
   CHECK (EXTRACT(YEAR FROM AGE(CURRENT_DATE, VALUE)) >= 21);

-- segundo esquema
CREATE DOMAIN esquema_grupo1_alt.domtipodoc AS VARCHAR(3)
   CHECK (VALUE IN ('DNI', 'PAS', 'CI', 'LC'))
   NOT NULL DEFAULT 'DNI';
 
CREATE DOMAIN esquema_grupo1_alt.domTipoHabitacion AS VARCHAR(20)
   CHECK (VALUE IN ('Simple', 'Doble', 'Suite', 'Twin', 'Triple', 'Cuadruple'))
   NOT NULL DEFAULT 'Simple';
 
CREATE DOMAIN esquema_grupo1_alt.domItemEvaluado AS VARCHAR(20)
   CHECK (VALUE IN ('COCINA', 'BANIO', 'LIVING', 'BALCON', 'LIMPIEZA', 'PUNTUALIDAD', 'RUIDO'));
 
CREATE DOMAIN esquema_grupo1_alt.ingresotexto AS VARCHAR(300)
   DEFAULT 'SIN DESCRIPCION';
 
CREATE DOMAIN esquema_grupo1_alt.precioNoche AS INTEGER
   CHECK (VALUE >= 20000)
   NOT NULL DEFAULT 20000;
 
CREATE DOMAIN esquema_grupo1_alt.domEstado AS VARCHAR(20)
   CHECK (VALUE IN ('Pendiente', 'Aceptada', 'Confirmada', 'Rechazada', 'Cancelada'));
 
CREATE DOMAIN esquema_grupo1_alt.montopagado AS BOOLEAN
   DEFAULT FALSE;
 
CREATE DOMAIN esquema_grupo1_alt.inicioReserva AS DATE
   CHECK (VALUE >= CURRENT_DATE);
 
CREATE DOMAIN esquema_grupo1_alt.edad AS DATE
   CHECK (EXTRACT(YEAR FROM AGE(CURRENT_DATE, VALUE)) >= 21);

