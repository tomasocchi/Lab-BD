--primer version
CREATE OR REPLACE FUNCTION cant_reservas(p_cliente INT) RETURNS INT AS $$ SELECT COUNT(*)::INT FROM reserva WHERE idUsuarioCliente = p_cliente; $$ LANGUAGE sql; 

--overloading
CREATE OR REPLACE FUNCTION cant_reservas(p_cliente INT, p_anio INT) RETURNS INT AS $$ SELECT COUNT(*)::INT FROM reserva WHERE idUsuarioCliente = p_cliente AND EXTRACT(YEAR FROM fechaInicio) = p_anio; $$ LANGUAGE sql; 

SELECT cant_reservas(1) AS total, cant_reservas(1, 2028) AS en_2028;

--ambas en el catalogo
SELECT p.proname, pg_get_function_identity_arguments(p.oid) AS parametros FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace WHERE n.nspname = 'esquema_grupo1' AND p.proname = 'cant_reservas';