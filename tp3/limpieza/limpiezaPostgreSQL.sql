SET search_path TO esquema_grupo1;

DROP TRIGGER IF EXISTS agregarReserva ON reserva;
DROP TRIGGER IF EXISTS eliminar_usuario_alojamiento ON Usuario_Alojamiento;
DROP TRIGGER IF EXISTS trg_log_reserva ON Reserva;
DROP TRIGGER IF EXISTS verificarLimiteReservas ON reserva;

DROP FUNCTION IF EXISTS incrementar_reservas();
DROP FUNCTION IF EXISTS eliminar_alojamiento_us();
DROP FUNCTION IF EXISTS registro_log_reserva();
DROP FUNCTION IF EXISTS verificar_usuario();

DROP PROCEDURE IF EXISTS listar_habitaciones_reservadas(VARCHAR);

DROP FUNCTION IF EXISTS fn_reservas_periodo(DATE, DATE);
DROP FUNCTION IF EXISTS diferencia_meses(DATE, DATE);
DROP FUNCTION IF EXISTS diferencia_meses2(DATE, DATE);
DROP FUNCTION IF EXISTS antiguedad_cliente(INTEGER);

DROP FUNCTION IF EXISTS cant_reservas(INT);
DROP FUNCTION IF EXISTS cant_reservas(INT, INT);

DROP TABLE IF EXISTS LOG_planillaControl;

ALTER TABLE usuario_cliente DROP COLUMN IF EXISTS cantidadReservasAnio;