proc print data=work.ACCIDENTES(obs=5);
  title "Primeras 5 observaciones de Df_Accidentes_Bogota_procesado";
run;

/* Corregir variables y cambiar comas por puntos en latitud/longitud */
data accidentes_corregido_final_txt;
    set work.ACCIDENTES;

    /* Reemplazar comas por puntos y convertir a numérico */
    latitud = input(tranwrd(latitud, ",", "."), best32.);
    longitud = input(tranwrd(longitud, ",", "."), best32.);


    /* Forzar variables a enteros y aplicar formato sin decimales */
    mes = int(round(mes, 1));   format mes 8.;
    año = int(round(año, 1));   format año 8.;
    dia = int(round(dia, 1));   format dia 8.;
    hora = int(round(hora, 1)); format hora 8.;

        /* Crear columnas de texto con comillas explícitas */
    año_txt  = cats('"', put("año"n, 4.), '"');
    mes_txt  = cats('"', put(mes, z2.), '"');
    dia_txt  = cats('"', put(dia, z2.), '"');
    hora_txt = cats('"', put(hora, z2.), '"');
    
    /* Etiquetas descriptivas */
    attrib 
        mes_txt  label="Mes (texto)"
        año_txt  label="Año (texto)"
        dia_txt  label="Día (texto)"
        hora_txt label="Hora (texto)";

    /* Generar un número tipo cédula único de 10 dígitos */
    ID = input(cats("1", put(rand("uniform")*1e9, z9.)), 10.);

    /* Asegurarse de que no haya duplicados (por si acaso) */

run;

/* Verificar que no hay decimales */
proc means data=work.accidentes_corregido_final_txt;
    var mes año dia hora;
run;

/* Verificar formatos */
proc contents data=work.accidentes_corregido_final_txt;
run;

/* ================================
   NUEVAS VARIABLES REQUERIDAS DE FECHA
   ================================ */
    
data accidentes_corregido_final_txt;
    set accidentes_corregido_final_txt;

    /* 1. Año y mes (sin día ni hora) */
    /* Primero extraemos el componente de fecha */
    fecha_temp = datepart(fecha_accidente);
    
    /* Luego creamos una fecha al primer día del mes */
    fecha_anio_mes = intnx('month', fecha_temp, 0, 'b');
    format fecha_anio_mes yymmd7.;  /* Mostrará "2023-JUL" */
    
    /* 2. Año, mes y día (sin hora) */
    fecha_anio_mes_dia = datepart(fecha_accidente);
    format fecha_anio_mes_dia yymmdd10.;  /* Formato YYYY-MM-DD */

    /* Eliminamos la variable temporal */
    drop fecha_temp;
    
    /* Etiquetas descriptivas */
    label fecha_anio_mes = "Fecha (Año y Mes)"
          fecha_anio_mes_dia = "Fecha (Año, Mes, Día)";
run;

/* Verificación */
proc print data=work.accidentes_corregido_final_txt(obs=5);
    var mes dia año hora latitud longitud mes_txt fecha_anio_mes_dia fecha_anio_mes ;
    title "Datos corregidos: Enteros y decimales con punto";
run;

/* Si quiero exportarlo */
/*proc export data=work.accidentes_corregido_final_txt
    outfile="~/accidentes_corregido_final_txt.csv"
    dbms=csv
    replace;
run; */





cas ;
caslib _ALL_ assign;
run;

data casuser.accidentes_corregido_txt_fechas (promote=yes);
set accidentes_corregido_final_txt;
run;

