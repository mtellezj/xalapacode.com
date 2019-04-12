+++
title = "Migrando a postgres (desde MySQL)"
date = "2018-12-30T17:00:00-06:00"
draft = false
thumbnail = ""
description = "En este post describiré algunas gratas sorpresas que encontré al migrar a postgres."
author = "Mauricio"
author_uri = "/directorio/mtellez"
+++

-------------------------------------------------------------------------------

## ¿Por qué MySQL? ##

Por muchos años trabajé con [MySQL] (https://www.mysql.com) (en
realidad aun lo hago, pero solo en un sistema que pronto terminará su
vida útil), y cuando empecé a usarlo allá por el año 2002, `MySQL` se
autoproclamaba como el motor de base de datos más rápido del
mundo. Esta velocidad tenía un coste, por ejemplo:

* No tenías integridad referencial.
* No tenías procedimientos almacenados.
* No existían los triggers.

Para la gran mayoría de sitios web con conexión a una _BD_ estas
limitantes no suponía un problema, incluso si necesitabas más
prestaciones que proporcionaban otros motores, la promesa de la
velocidad del rayo era muy tentadora. Es así como me decanté por MySQL.

Debo de reconocer que por mucho tiempo fui feliz con MySQL, incluso
hasta el día de hoy me ha dado de comer :grin:, sin embargo, los
tiempos cambian y los requerimientos de uso también; MySQL ya no es
necesariamente la opción más rápida (ni la más viable después de su
compra por parte de Oracle), y su falta de opciones _avanzadas_ como
las **window functions** lo descartan para su uso en nichos
particulares.

## ¿Por qué Postgres? ##

Hace aproximadamente un año empecé la migración de un sistema
programado en PHP/MySQL a Python/Django/Postgres, y mi selección del motor de
base datos la hice en base a las necesidades propias del sistema, pero
sobre todo a las carencias de MySQL para lo que yo estaba
haciendo. Algunas de estas necesidades son:

### Tablas pivote ###

En ocasiones es necesario convertir información que está en un formato
horizontal a vertical y viceversa:

* Tabla en formato vertical

Dispositivo|Fecha|Error
---|---|---
Lámpara|2019-01-01|1
Lámpara|2019-01-01|1
Lámpara|2019-01-01|3
Lámpara|2019-01-01|5
Lámpara|2019-01-01|3
Lámpara|2019-01-02|2
Banda magnética|2019-01-01|2
Banda magnética|2019-01-01|5
Banda magnética|2019-01-01|2
Banda magnética|2019-01-01|2
Banda magnética|2019-01-01|5
Banda magnética|2019-01-02|1
Banda magnética|2019-01-02|3
Banda magnética|2019-01-02|4

* Tabla en formato horizontal (sumando las incidencias)

| Dispositivo     | Fecha      | E1 | E2 | E3 | E4 | E5 |
|-----------------|------------|----|----|----|----|----|
| Lámpara         | 2019-01-01 | 2  |    | 2  |    | 5  |
| Lámpara         | 2019-01-02 |    | 1  |    |    |    |
| Bánda Magnética | 2019-01-01 |    | 3  |    |    | 2  |
| Banda Magnética | 2019-01-02 | 1  |    | 1  | 1  |    |

### Sets, Rollup y Cube ###

Todas estas funciones agrupan información de una forma u otra, lo que
permite realizar operaciones que con un simple `GROUP BY` es casi
imposible.

#### Grouping sets ####

En ocasiones queremos crear un resumen con diferentes permutaciones de
campos, y la forma *común* de realizarlo, es crear una consulta para
cada permuta, y después unir todo con `UNION ALL`. Esto no solo
produce queries muy largos, sino ineficientes por que se tiene que
recorrer la tabla una vez por permuta. Usando los **grouping sets**
nuesta consulta no solo será más compacta, sino también más eficiente,
por que la tabla solo se recorre una sola vez.

### Window Functions ###

A grandes rasgos, estas funciones trabajan sobre un conjuto de filas
como lo hace `GROUP BY`, pero con la diferencia que el resultado no se
agrupa en un solo renglón. Un caso de uso real es el siguiente:

> Sacar los totales de clientes por tienda y mostrar la suma y el
> promedio de los clientes para cada zona y región, mostrando estos
> dos últimos datos en una columna a la derecha y únicamente en los
> renglones de la última zona/región. Las demás celdas de esta columna
> deberán ir en blanco.

### Cláusula WITH ###

También conocidas como *Expresiones de Tabla Comunes* (`CTEs` por sus siglas en inglés) nos permiten agrupar sentencias SQL para reutilizarlas en consultas complejas, en la práctica funcionan como las subconsultas, pero son más poderasas y tienen alcances diferentes.
