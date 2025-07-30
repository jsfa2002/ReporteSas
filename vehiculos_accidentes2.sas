/* Primero, creamos una tabla con los vehículos originales */
data vehiculos_movilidad_faj;
    set accidentes_corregido_final_txt(keep=ID);
    ID_persona = ID;

    /* Simular tipo de vehículo */
    array tipos{3} $20 _temporary_ ("Automóvil", "Motocicleta", "Camión");
    tipo_vehiculo = tipos[ceil(rand("uniform") * dim(tipos))];

    /* Simular clase de servicio */
    array clases{3} $20 _temporary_ ("Particular", "Público", "Oficial");
    clase_servicio = clases[ceil(rand("uniform") * dim(clases))];

    /* Simular marca */
    array marcas{6} $20 _temporary_ ("Chevrolet", "Renault", "Mazda", "Kia", "Toyota", "Suzuki");
    marca = marcas[ceil(rand("uniform") * dim(marcas))];

    /* Año y modelo */
    modelo = rand("integer", 2005, 2024);
    año_fabricacion = modelo;
    antiguedad = year(today()) - año_fabricacion;

    /* Número de chasis y motor */
    numero_chasis = cats("CH", put(rand("integer", 100000, 999999), z6.));
    numero_motor = cats("MT", put(rand("integer", 100000, 999999), z6.));

    /* Placa según tipo */
    length placa $10;
    if tipo_vehiculo = "Motocicleta" then do;
        placa = cats(
            byte(65 + rand("integer", 0, 25)),
            byte(65 + rand("integer", 0, 25)),
            byte(65 + rand("integer", 0, 25)),
            put(rand("integer", 10, 99), z2.),
            byte(65 + rand("integer", 0, 25))
        );
    end;
    else do;
        placa = cats(
            byte(65 + rand("integer", 0, 25)),
            byte(65 + rand("integer", 0, 25)),
            byte(65 + rand("integer", 0, 25)),
            put(rand("integer", 0, 999), z3.)
        );
    end;

    keep ID_persona placa tipo_vehiculo clase_servicio marca modelo año_fabricacion 
         numero_chasis numero_motor antiguedad;
run;

/* Ahora duplicamos algunos registros para asignarles un segundo vehículo */
data vehiculos_extra;
    set vehiculos_movilidad_faj;
    if rand("uniform") < 0.15 then do; /* Solo el 15% de las personas tendrán un segundo vehículo */

        /* Cambiamos los datos del segundo vehículo */
        array tipos{3} $20 _temporary_ ("Automóvil", "Motocicleta", "Camión");
        tipo_vehiculo = tipos[ceil(rand("uniform") * dim(tipos))];

        array clases{3} $20 _temporary_ ("Particular", "Público", "Oficial");
        clase_servicio = clases[ceil(rand("uniform") * dim(clases))];

        array marcas{6} $20 _temporary_ ("Chevrolet", "Renault", "Mazda", "Kia", "Toyota", "Suzuki");
        marca = marcas[ceil(rand("uniform") * dim(marcas))];

        modelo = rand("integer", 2005, 2024);
        año_fabricacion = modelo;
        antiguedad = year(today()) - año_fabricacion;

        numero_chasis = cats("CH", put(rand("integer", 100000, 999999), z6.));
        numero_motor = cats("MT", put(rand("integer", 100000, 999999), z6.));

        length placa $10;
        if tipo_vehiculo = "Motocicleta" then do;
            placa = cats(
                byte(65 + rand("integer", 0, 25)),
                byte(65 + rand("integer", 0, 25)),
                byte(65 + rand("integer", 0, 25)),
                put(rand("integer", 10, 99), z2.),
                byte(65 + rand("integer", 0, 25))
            );
        end;
        else do;
            placa = cats(
                byte(65 + rand("integer", 0, 25)),
                byte(65 + rand("integer", 0, 25)),
                byte(65 + rand("integer", 0, 25)),
                put(rand("integer", 0, 999), z3.)
            );
        end;

        output;
    end;
    else delete;
run;

/* Unimos los datos originales con los adicionales */
data vehiculos_final;
    set vehiculos_movilidad_faj vehiculos_extra;
run;

proc sql;
    select ID_persona, count(*) as cantidad
    from vehiculos_movilidad_faj
    group by ID_persona
    having count(*) > 1;
quit;


/* Guardamos en CAS con reemplazo */
data casuser.vehiculos_movilidad_faj (promote=yes replace=yes);
    set vehiculos_final;
run;
