data base_legal_movilidad_faj;
    set vehiculos_final(keep=ID_persona);

    

    licencia_num = put(int(rand("uniform")*1E8), z8.);
    array categorias{5} $ ("A1", "A2", "B1", "C1", "C2");
    categoria = categorias[ceil(rand("uniform")*5)];

    fecha_expedicion = intnx("year", today(), -int(rand("uniform")*20), "s");
    fecha_vencimiento = intnx("year", fecha_expedicion, 10, "s");

    estado_licencia = ifc(rand("bernoulli", 0.85), "Vigente", 
                        ifc(rand("bernoulli", 0.5), "Suspendida", "Cancelada"));

    total_comparendos = rand("integer", 0, 10);
    comparendos_pendientes = rand("integer", 0, min(3, total_comparendos));
    comparendos_pagados = total_comparendos - comparendos_pendientes;

    if total_comparendos > 0 then 
        fecha_ultimo_comparendo = intnx("month", today(), -rand("integer", 1, 36), "s");

    array infracciones{3} $ ("Velocidad", "Alcoholemia", "Mal parqueo");
    tipo_infraccion_frecuente = infracciones[ceil(rand("uniform")*3)];

    restricciones = ifc(rand("bernoulli", 0.1), "Sí", "No");

    format fecha_expedicion fecha_vencimiento fecha_ultimo_comparendo yymmdd10.;

    keep ID_persona licencia_num categoria fecha_expedicion fecha_vencimiento estado_licencia
         total_comparendos comparendos_pendientes comparendos_pagados fecha_ultimo_comparendo
         tipo_infraccion_frecuente restricciones;
run;

data casuser.base_legal_movilidad_faj (promote=yes);
    set base_legal_movilidad_faj;
run;

proc sql;
    select ID_persona, count(*) as cantidad
    from base_legal_movilidad_faj
    group by ID_persona
    having count(*) > 1;
quit;
