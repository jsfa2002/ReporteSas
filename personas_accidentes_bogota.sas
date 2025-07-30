data personas_movilidad_faj;
    set accidentes_corregido_final_txt(keep=ID);

    ID_persona = ID;

    /* Edad entre 18 y 70 */
    edad = int(rand("uniform")*53 + 18);

    /* Género */
    genero = ifc(rand("bernoulli", 0.5), "Hombre", "Mujer");

    /* Estado civil */
    array estados{4} $ ("Soltero", "Casado", "Divorciado", "Unión libre");
    estado_civil = estados[ceil(rand("uniform")*4)];

    /* Nivel educativo */
    array niveles{5} $ ("Primaria", "Secundaria", "Técnico", "Universitario", "Postgrado");
    nivel_educativo = niveles[ceil(rand("uniform")*5)];

    /* Ocupación */
    array ocup{5} $ ("Estudiante", "Empleado", "Independiente", "Desempleado", "Jubilado");
    ocupacion = ocup[ceil(rand("uniform")*5)];

    /* Condición laboral */
    array cond_lab{5} $ ("Empleado", "Desempleado", "Informal", "Jubilado", "Estudiante");
    condicion_laboral = cond_lab[ceil(rand("uniform")*5)];

    /* Ingresos mensuales */
    ingresos_mensuales = round(rand("normal", 2000000, 1000000), 10000); 

    /* Tipo de vivienda */
    array vivienda{3} $ ("Propia", "Alquilada", "Prestada");
    tipo_vivienda = vivienda[ceil(rand("uniform")*3)];

    /* Personas en el hogar */
    num_personas_hogar = ceil(rand("uniform")*5) + 1;

    /* Nacionalidad */
    nacionalidad_rand = rand("uniform");
    if nacionalidad_rand <= 0.8 then nacionalidad = "Colombiana";
    else if nacionalidad_rand <= 0.95 then nacionalidad = "Venezolana";
    else nacionalidad = "Otra Latinoamérica";

    pais = "Colombia";

    /* Municipio de nacimiento */
    array municipios{5} $ ("Bogotá", "Medellín", "Cali", "Barranquilla", "Bucaramanga");
    municipio_nacimiento = municipios[ceil(rand("uniform")*5)];

    /* Zona */
    zona = ifc(rand("bernoulli", 0.3), "Rural", "Urbana");

    /* Discapacidad */
    discapacidad = ifc(rand("bernoulli", 0.05), "Sí", "No");

    keep ID_persona edad genero estado_civil nivel_educativo ocupacion condicion_laboral 
         ingresos_mensuales tipo_vivienda num_personas_hogar nacionalidad pais 
         municipio_nacimiento zona discapacidad;
run;

data casuser.personas_movilidad_faj (promote=yes);
    set personas_movilidad_faj;
run;
