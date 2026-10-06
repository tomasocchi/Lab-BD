DO $$
DECLARE
    cur_reservas SCROLL CURSOR FOR
        SELECT idReserva, fechaInicio, precioTotal
        FROM Reserva
        ORDER BY idReserva;
    reg RECORD;
BEGIN
    OPEN cur_reservas;

    MOVE FIRST FROM cur_reservas;
    FETCH RELATIVE 0 FROM cur_reservas INTO reg;
    RAISE NOTICE 'MOVE FIRST -> idReserva=%, fecha=%, precio=%', reg.idReserva, reg.fechaInicio, reg.precioTotal;

    FETCH NEXT FROM cur_reservas INTO reg;
    FETCH NEXT FROM cur_reservas INTO reg;
    RAISE NOTICE 'Tras 2 FETCH NEXT -> idReserva=%, fecha=%, precio=%', reg.idReserva, reg.fechaInicio, reg.precioTotal;

  
    MOVE PRIOR FROM cur_reservas;
    FETCH RELATIVE 0 FROM cur_reservas INTO reg;
    RAISE NOTICE 'MOVE PRIOR -> idReserva=%, fecha=%, precio=%', reg.idReserva, reg.fechaInicio, reg.precioTotal;


    MOVE LAST FROM cur_reservas;
    FETCH RELATIVE 0 FROM cur_reservas INTO reg;
    RAISE NOTICE 'MOVE LAST -> idReserva=%, fecha=%, precio=%', reg.idReserva, reg.fechaInicio, reg.precioTotal;


    MOVE ABSOLUTE 3 FROM cur_reservas;
    FETCH RELATIVE 0 FROM cur_reservas INTO reg;
    RAISE NOTICE 'MOVE ABSOLUTE 3 -> idReserva=%, fecha=%, precio=%', reg.idReserva, reg.fechaInicio, reg.precioTotal;

    CLOSE cur_reservas;
END