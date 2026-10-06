--  diferencia_meses con raise notice

CREATE OR REPLACE FUNCTION diferencia_meses(fecha1 DATE, fecha2 DATE)
RETURNS INTEGER AS $$
DECLARE
    anio1 INTEGER;
    anio2 INTEGER;
    mes1  INTEGER;
    mes2  INTEGER;
    dif_meses INTEGER;
BEGIN
    RAISE NOTICE 'Se ejecuta el cuerpo de diferencia_meses';
 
    anio1 := EXTRACT(YEAR FROM fecha1);
    anio2 := EXTRACT(YEAR FROM fecha2);
    mes1  := EXTRACT(MONTH FROM fecha1);
    mes2  := EXTRACT(MONTH FROM fecha2);
 
    dif_meses := (anio2 - anio1) * 12 + (mes2 - mes1);
 
    RETURN ABS(dif_meses);
END;
$$ LANGUAGE plpgsql;


-- diferencia_meses2 con raise notice

CREATE OR REPLACE FUNCTION diferencia_meses2(fecha1 DATE, fecha2 DATE)
RETURNS INTEGER
RETURNS NULL ON NULL INPUT
AS $$
DECLARE
    anio1 INTEGER;
    anio2 INTEGER;
    mes1  INTEGER;
    mes2  INTEGER;
    dif_meses INTEGER;
BEGIN
    RAISE NOTICE 'Se ejecuta el cuerpo de diferencia_meses2';
 
    anio1 := EXTRACT(YEAR FROM fecha1);
    anio2 := EXTRACT(YEAR FROM fecha2);
    mes1  := EXTRACT(MONTH FROM fecha1);
    mes2  := EXTRACT(MONTH FROM fecha2);
 
    dif_meses := (anio2 - anio1) * 12 + (mes2 - mes1);
 
    RETURN ABS(dif_meses);
END;
$$ LANGUAGE plpgsql;