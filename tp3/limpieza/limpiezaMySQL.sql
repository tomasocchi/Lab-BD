DROP TRIGGER IF EXISTS agregarReserva;
DROP TRIGGER IF EXISTS eliminar_usuario_alojamiento;
DROP TRIGGER IF EXISTS trg_insertar_log_reserva;
DROP TRIGGER IF EXISTS trg_modificar_log_reserva;
DROP TRIGGER IF EXISTS trg_borrar_log_reserva;
DROP TRIGGER IF EXISTS verificarLimiteReservas;

DROP PROCEDURE IF EXISTS sp_reservas_periodo;
DROP PROCEDURE IF EXISTS listar_habitaciones_reservadas;

DROP FUNCTION IF EXISTS diferencia_meses;
DROP FUNCTION IF EXISTS antiguedad_cliente;

DROP TABLE IF EXISTS LOG_planillaControl;

ALTER TABLE usuario_cliente DROP COLUMN cantidadReservasAnio;