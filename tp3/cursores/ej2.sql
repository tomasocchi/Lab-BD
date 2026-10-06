DO $$
DECLARE
    cur_reservas_baratas CURSOR FOR
        SELECT idReserva, precioTotal
        FROM Reserva
        WHERE precioTotal < 100000
        FOR UPDATE;
    reg RECORD;
BEGIN
    OPEN cur_reservas_baratas;
    LOOP
        FETCH cur_reservas_baratas INTO reg;
        EXIT WHEN NOT FOUND;

        UPDATE Reserva
        SET precioTotal = precioTotal * 0.95
        WHERE CURRENT OF cur_reservas_baratas;

        RAISE NOTICE 'Reserva % actualizada: $% -> $%', reg.idReserva, reg.precioTotal, reg.precioTotal * 0.95;
    END LOOP;
    CLOSE cur_reservas_baratas;
END;
$$;