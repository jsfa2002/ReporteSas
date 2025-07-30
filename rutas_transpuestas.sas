data paso1 paso2;
    set rutas_movilidad_faj;
    if paso = 1 then output paso1;
    else if paso = 2 then output paso2;
run;

proc sort data=paso1; by ID_persona; run;
proc sort data=paso2; by ID_persona; run;

data rutas_unidas;
    merge paso1(rename=(
        latitud=latitud_paso1
        longitud=longitud_paso1
        calle=calle_paso1
        sector=sector_paso1
        tiempo=tiempo_paso1
        tipo_paso=tipo_paso1
    ))
    paso2(rename=(
        latitud=latitud_paso2
        longitud=longitud_paso2
        calle=calle_paso2
        sector=sector_paso2
        tiempo=tiempo_paso2
        tipo_paso=tipo_paso2
    ));
    by ID_persona;
run;

data casuser.rutas_unificadas (promote=yes);
    set rutas_unidas;
run;
