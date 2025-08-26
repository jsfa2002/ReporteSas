

data rutas_movilidad_faj(keep=ID_persona barrio paso latitud longitud calle sector tiempo tipo_paso);
    set accidentes_unificado(keep=ID_persona barrio latitud longitud);
    
    /* Simular coordenadas de origen y destino */
    lat_origen = latitud + rand("Uniform") * 0.01 - 0.005;
    lon_origen = longitud + rand("Uniform") * 0.01 - 0.005;

    lat_destino = latitud + rand("Uniform") * 0.02 - 0.01;
    lon_destino = longitud + rand("Uniform") * 0.02 - 0.01;

    /* Simular calles y sectores */
    array calles{5} $30 _temporary_ ("Calle 13", "Av. Suba", "Calle 72", "Carrera 30", "Diagonal 45");
    array carreras{5} $30 _temporary_ ("Cra 7", "Cra 15", "Cra 68", "Cra 11", "Cra 24");
    array sectores{5} $20 _temporary_ ("Chapinero", "Suba", "Teusaquillo", "Usaquén", "Fontibón");

    calle_origen = catx(" con ", calles[ceil(rand("Uniform")*5)], carreras[ceil(rand("Uniform")*5)]);
    calle_destino = catx(" con ", calles[ceil(rand("Uniform")*5)], carreras[ceil(rand("Uniform")*5)]);

    sector_origen = sectores[ceil(rand("Uniform")*5)];
    sector_destino = sectores[ceil(rand("Uniform")*5)];

    /* Simular tiempos */
    tiempo_salida = dhms(today(), int(rand("Uniform")*24), int(rand("Uniform")*60), 0);
    duracion_segundos = int(rand("Uniform")*1800 + 600); /* entre 10 y 40 min */
    tiempo_llegada = tiempo_salida + duracion_segundos;

    /* Primer paso: origen */
    paso = 1;
    latitud = lat_origen;
    longitud = lon_origen;
    calle = calle_origen;
    sector = sector_origen;
    tiempo = tiempo_salida;
    tipo_paso = "origen";
    output;

    /* Segundo paso: destino */
    paso = 2;
    latitud = lat_destino;
    longitud = lon_destino;
    calle = calle_destino;
    sector = sector_destino;
    tiempo = tiempo_llegada;
    tipo_paso = "destino";
    output;

run;

cas casauto;
libname casuser cas caslib="casuser";

data casuser.rutas_movilidad_faj (promote=yes);
    set rutas_movilidad_faj;
run;


