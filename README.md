# Reporte Sas

##  Proyecto de Análisis de Accidentes de Tránsito en Bogotá con SAS

Este repositorio contiene el flujo completo para procesar, transformar y unificar datos de accidentes de tránsito en Bogotá usando SAS Studio.  
El resultado final es una demo funcional para el análisis de rutas y movilidad, la cual puede explorarse en SAS Visual Analytics.

---

##  Objetivo del Proyecto

El propósito del proyecto es construir una base integrada de accidentes de tránsito, complementada con información simulada sobre vehículos, personas involucradas, aspectos legales y trayectorias de movilidad.  

Esto permite:
- Analizar patrones de accidentes en Bogotá.  
- Relacionar variables demográficas, legales y de movilidad.  
- Generar una demo de análisis de rutas como caso de uso en SAS Visual Analytics.  

---

##  Requisitos

- **SAS Studio** instalado o acceso vía servidor.  
- Archivo CSV `datos_finales_exportado.csv` en este repositorio.  
- Archivo JSON de configuración de rutas (se debe importar en SAS Studio).  
- Acceso a SAS Visual Analytics para abrir el reporte final.  

---

##  Guía de Ejecución

Todos los archivos necesarios están en este repositorio, los códigos están en la carpeta "codigos_sas_movilidad" en .zip o en la carpeta "code".

Sigue los siguientes pasos en orden:

1. **Importar los datos base**  
   - Ejecutar `carga_accidentes_bogota.sas`  
   - Importa el CSV `accidentes_bogota_procesado.csv` en la carpeta zip llamada accidentes procesados, en este repositorio, y el archivo `.JSON` de rutas/configuración.  

2. **Procesamiento de datos**  
   Ejecuta en orden los siguientes scripts, cada uno construye nuevas tablas con variables adicionales:

    2.1 `accidentes_bogota.sas`
   - Limpieza de la tabla `ACCIDENTES`:
     - Convierte latitud/longitud a numéricos.  
     - Redondea variables de tiempo (`año`, `mes`, `día`, `hora`).  
     - Crea identificador único `ID`.  
     - Genera variables de fecha (`fecha_anio_mes`, `fecha_anio_mes_dia`).  
   - **Tabla generada:** `accidentes_corregido_final_txt`.

    2.2 `vehiculos_accidentes2.sas`
   - Simula vehículos asociados a cada accidente:  
     - `ID_persona`, `placa`, `tipo_vehiculo`, `clase_servicio`, `marca`, `modelo`, `año_fabricacion`, `antiguedad`.  
     - Números de chasis y motor.  
   - Algunos individuos reciben más de un vehículo.  
   - **Tabla generada:** `vehiculos_final`.

    2.3 `personas_accidente_bogota.sas`
   - Simula características de las personas involucradas:  
     - `edad`, `genero`, `estado_civil`, `nivel_educativo`, `ocupacion`, `condicion_laboral`.  
     - `ingresos_mensuales`, `tipo_vivienda`, `num_personas_hogar`.  
     - Variables de contexto: `nacionalidad`, `municipio_nacimiento`, `zona`, `discapacidad`.  
   - **Tabla generada:** `personas_movilidad_faj`.

    2.4 `base_legal_accidentes.sas`
   - Simula información legal asociada a conductores:  
     - `licencia_num`, `categoria`, `fecha_expedicion`, `fecha_vencimiento`.  
     - Estado de licencia (`vigente`, `suspendida`, `cancelada`).  
     - Comparendos: `total`, `pagados`, `pendientes`, `fecha_ultimo_comparendo`.  
     - Infracciones frecuentes y restricciones.  
   - **Tabla generada:** `base_legal_movilidad_faj`.

    2.5 `accidentes_unificado.sas`
   - Integra todas las tablas en una sola:  
     - Une accidentes, vehículos, personas, base legal y rutas.  
   - **Tabla final:** `accidentes_unificado`.
   - 
    2.6 `path_ruta.sas`
   - Simula trayectorias de movilidad (origen y destino):  
     - `ID_persona`, `latitud`, `longitud`, `calle`, `sector`, `tiempo`, `tipo_paso` (`origen`/`destino`).  
     - Se generan tiempos de salida y llegada, con duración aleatoria entre 10 y 40 minutos.  
   - **Tabla generada:** `rutas_movilidad_faj`.

    2.7 `rutas_transpuestas.sas`
   - Reestructura las rutas en formato transpuesto:  
     - Combina pasos de origen y destino por persona.  
     - Variables: `latitud_paso1`, `longitud_paso1`, `calle_paso1`, `sector_paso1`, `tiempo_paso1`, y sus equivalentes para paso 2.  
   - **Tabla generada:** `rutas_unificadas`.

3. **Visualización del Reporte**  
   - Abrir SAS Visual Analytics.  
   - Cargar la tabla `accidentes_unificado`.  
   - Explorar el Reporte de Movilidad, que permite analizar rutas, perfiles de conductores, accidentes y características asociadas.  

---

##  Producto Final

El producto entregado es:  
- **Una demo en SAS Visual Analytics** para el **análisis de rutas y movilidad** en Bogotá.  
- Tablas simuladas que permiten estudiar la interacción entre:  
  - Accidentes  
  - Vehículos  
  - Personas involucradas  
  - Aspectos legales  
  - Trayectorias de movilidad  

Esta estructura se puede ampliar o conectar con fuentes de datos reales para futuros análisis.  

---

##  Autores
- **Jalenna Correa**  
- **Juan Sebastián Fajardo**  

---
