## Empecemos

Este repositorio adjunta todos los scripts, diagramas y backups necesarios para trabajar el proceso completo de Inteligencia de Negocios en la jardineria.

## Estructura de carpetas

Nuestro espacio de trabajo contiene dos carpetas, observe:

- `Backups`: Aquí encuentras los backups realizados en cada base de datos.
- `Scripts`: Aquí encuentras los scripts de sql necesarios para ejecutar todo el proceso (Desde la base datos, hasta el Data Mart).
- `Data Quality`: Aquí encuentras el script automatizado de Python que ejecuta las queries para validar la integridad y calidad de los datos.
- `Resources`: Aquí encuentras los archivos de diagramas de nuestro proyecto.

## Manejo de dependencias

Para que todo el proceso funcione adecuadamente, requieres de:

- Python
- Postgres
- Psycopg

## Detallando lo trabajado

Dentro del proceso de Inteligencia de Negocios, la construcción integral de la solución no se limita únicamente al diseño de la base de datos transaccional o al establecimiento del Staging Area; requiere además avanzar hacia la consolidación de un Data Mart confiable y la implementación de mecanismos que garanticen la calidad de los datos. En este sentido, el presente proyecto abarca de manera completa el ciclo que inicia en la base de datos de origen, pasa por el área de staging y culmina en la conformación del Data Mart todo esto mediante el importante proceso conocido como ETL.

Observemos nuestro esquema de tablas de la Base de Datos:

![image text](https://github.com/ingJuanArenas/IntegracionFinalBD2/blob/main/Resources/Pictures/DB.png)

A continuación, nuestro esquema de Staging Area:

![image text](https://github.com/ingJuanArenas/IntegracionFinalBD2/blob/main/Resources/Pictures/Staging.png)

Finalmente, nuestro Data Mart:

![image text](https://github.com/ingJuanArenas/IntegracionFinalBD2/blob/main/Resources/Pictures/DataMart.png)

Tras haber desarrollado el proceso de arquitectura y de haber definido el ETL, es momento de ejecutar las pruebas de calidad de datos, esto garantiza que el Data Mart sea confiable para la organizacion:

![image text](https://github.com/ingJuanArenas/IntegracionFinalBD2/blob/main/Resources/Pictures/pruebas.jpg)

En conclusion, este trabajo no solo asegura la disponibilidad de los datos, sino también su depuración y validación, mediante pruebas específicas de calidad que confirman la completitud, unicidad y consistencia de los registros. De este modo, la organización puede disponer de un repositorio analítico confiable y alineado con las necesidades estratégicas, capaz de responder con precisión a preguntas clave del negocio.
