data accidentes_final;
    set accidentes_corregido_final_txt;
    ID_persona = ID;
    drop ID;
run;

proc sql;
    create table accidentes_unificado as
    select *
    from accidentes_final a
    left join vehiculos_final v
        on a.ID_persona = v.ID_persona
    left join personas_movilidad_faj p
        on a.ID_persona = p.ID_persona
    left join base_legal_movilidad_faj b
        on a.ID_persona = b.ID_persona
    ;
quit;

data casuser.accidentes_unificado (promote=yes);
    set accidentes_unificado;
run;

