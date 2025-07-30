# Reporte Sas

## Proyecto de Análisis de Accidentes de Tránsito en Bogotá con SAS

Este repositorio contiene los archivos necesarios para importar, procesar y unificar bases de datos relacionadas con accidentes de tránsito en Bogotá, usando SAS Studio. Al final del flujo de trabajo, se podrá visualizar un reporte en **SAS Visual Analytics**.

### Requisitos

- Acceso a **SAS Studio**
- Archivo CSV llamado `datos_finales_exportado.csv`
- Acceso a **SAS Visual Analytics** para visualizar el reporte final
- 
### Guía de Ejecución

Sigue los siguientes pasos en orden para garantizar la correcta ejecución del flujo de trabajo:

1. **Importar los datos**  
   Ejecuta el script `carga_accidentes_bogota.sas` ubicado en la carpeta `codigos/`. Guíate del código según tu usuario y ruta en sas y en tu computador. 
   Este paso permite cargar el archivo `datos_finales_exportado.csv` a SAS.

2. **Procesamiento de datos**  
   Ejecuta, en el siguiente orden, los siguientes archivos `.sas`:
   
   - `accidentes_bogota.sas`
   - `vehiculos_accidentes2.sas`
   - `personas_accidente_bogota.sas`
   - `base_legal_accidentes.sas`
   - `path_ruta.sas`
   - `rutas_transpuestas.sas`
   - `accidentes_unificado.sas`

   Cada uno de estos scripts realiza un paso clave en la transformación y consolidación de las bases de datos.

3. **Visualización del Reporte**  
   Una vez finalizado el procesamiento, accede a **SAS Visual Analytics** y abre el reporte de movilidad generado con base en los datos unificados.

## Autor
Jalenna Correa y Juan Sebastián Fajardo
Este proyecto fue desarrollado como parte de un trabajo en SAS Studio para analizar la movilidad y los accidentes de tránsito en Bogotá.

---
