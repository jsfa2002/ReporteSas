/* 1) Definir referencia al archivo CSV */
filename REFFILE filesrvc
    folderpath='/Users/juansebastian.fajardo.external@sas.com/My Folder/JsfaScripts/Data'
    filename='accidentes_bogota_procesado.csv'
;

/* 2) Importar el CSV */
data work.accidentes;
    infile REFFILE dsd firstobs=2 lrecl=32767 encoding='utf-8';
    informat 
        fecha_accidente anydtdtm20.
        dispositivo_control_trafico $50.
        condicion_climatica $30.
        condicion_luminica $30.
        tipo_accidente $30.
        tipo_via $20.
        alineacion $30.
        condicion_superficie $30.
        defecto_vial $30.
        tipo_colision $50.
        relacionado_interseccion $10.
        danos $30.
        causa_contributiva_principal $50.
        numero_vehiculos 8.
        lesion_mas_grave $40.
        total_lesiones 8.
        lesiones_fatales 8.
        lesiones_incapacitating 8.
        lesiones_no_incapacitating 8.
        lesiones_reportadas_no_evidentes 8.
        sin_indicacion_lesion 8.
        mes 8.
        dia 8.
        año 8.
        hora 8.
        barrio $40.
        latitud best32.
        longitud best32.
    ;
    format fecha_accidente datetime20.;
    input 
        fecha_accidente : anydtdtm20.
        dispositivo_control_trafico : $50.
        condicion_climatica : $30.
        condicion_luminica : $30.
        tipo_accidente : $30.
        tipo_via : $20.
        alineacion : $30.
        condicion_superficie : $30.
        defecto_vial : $30.
        tipo_colision : $50.
        relacionado_interseccion : $10.
        danos : $30.
        causa_contributiva_principal : $50.
        numero_vehiculos
        lesion_mas_grave : $40.
        total_lesiones
        lesiones_fatales
        lesiones_incapacitating
        lesiones_no_incapacitating
        lesiones_reportadas_no_evidentes
        sin_indicacion_lesion
        mes
        dia
        año
        hora
        barrio : $40.
        latitud
        longitud
    ;
run;
