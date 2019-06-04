+++
title = "Backup Tips"
date = "2019-06-03T12:00:00-06:00"
draft = false
thumbnail = "/img/blog/imagen.png"
description = "Algunos consejos para respaldar tu información"
markup = "mmark"
author = "Mauricio Téllez"
author_uri = "/directorio/mtellez"
+++

# Introducción

Uno de los puntos mas importantes al reinstalar un sistema operativo
es el de respaldar nuestra información (datos personales) y la
información del sistema (configuraciones de servicios, scripts,
etc). La complejidad de esta tarea es proporcional a la cantidad de
datos y al esquema de particionado usado.

### Sistemas con una partición

Si tenemos linux instalado en usa sola partición raíz `/`, entonces
sera necesario respaldar todos los datos por que al reinstalar el
sistema se sobrescribirá dicha partición.

### Sistemas con múltiples particiones

El trabajo se simplifica cuando tenemos varias particiones para distintos propósitos, como:

* `/`
* `/home`
* `/usr/local`
* `/opt`

En estos casos, al reinstalar el sistema solo se reescribirá la
partición *raíz*, pero los datos de las demás particiones no, por lo
que nuestros datos estarán a salvo. Hay que recalcar que incluso con un
sistema de particiones como este, **siempre hay que respaldar** la
información.

# `tar`: la navaja suiza de los respaldos

El comando data de 1979 y estaba pensado para escribir en medios
secuenciales, como las cintas de respaldo de ahí su nombre **t**ape
**ar**chive. Este comando ha evolucionado mucho y ahora nos permite
crear respaldos de diferentes formas, incluyendo la compresión de
datos. La forma de uso es bastante simple, como veremos a continuación.

### Creando un respaldo

    tar opciones nombre_respaldo.tar archivo1 [archivo2 directorio1...]
    
en las opciones, las mas comunes son `c` para crear un archivo, `f`
para indicar el nombre del respaldo, `z` para crear archivos *.zip*,
`j` para comprimir los archivos usando *bzip2*, `x` para extraer los
archivos y `t` para mostrar el contenido del archivo. Al crear el
archivo no es mandatorio poner una extensión, pero por convención se
usa `.tar` para los archivos sin comprimir, `.tgz` o `.tar.gz` para
los archivos comprimidos usando `z` y `.tar.bz2` o `.tbz2` para los
archivos creados usando la opción `j`. Después del nombre necesitamos
especificar los archivos y directorios a incluir en el archivador,
pudiendo estar estos archivos en diferentes rutas:

    tar cjf fotos.tbz2 vacaciones/ /tmp/pic.png
    
en este caso el archivador incluirá al directorio `vacaciones` (la
diagonal al final no es necesaria, solo la incluí como pista visual)
en el directorio actual y el archivo `pic.png` en el directorio
`/tmp`.


### Extrayendo los datos

Este proceso es aun mas sencillo, solo necesitamos posicionarnos en el
directorio donde queremos los datos, y desde ahí ejecutamos el
comando:

    tar xjf fotos.tbz2
    
Como el respaldo lo creamos usando el modificador `j`, también lo
tenemos que especificar en la extracción. Esto nos recreará una serie
de directorios que corresponde a los que se especificaron en el
momento de la creación, por lo que debemos poner atención en donde lo
descomprimimos.

# Opciones para optimizar los respaldos

Entre mas datos tenemos mas tardado se vuele el proceso de
respaldo. Recientemente hice un respaldo de 600gb, y después de 10
horas aun no terminaba, por lo que me di a la tarea de regresar a lo
básico para optimizar el proceso:

1. Hacer una limpieza de nuestros datos. El historial de los
   navegadores tienen información que se puede eliminar sin problemas,
   los archivos en el directorio de descargas que tienen años ahí y no
   se usan, etc.
1. Si tenemos espacio de sobra, omitir la compresión de datos, y
   utilizar `tar` únicamente para crear el archivador.
1. Crear archivos "al vuelo".

### Limpieza de nuestros datos

Esto aunque resulta obvio muy pocas veces lo hacemos. De los 600gb que
tenía en un inicio, me puse a borrar todo lo innecesario (incluyendo
varias imágenes iso) y reduje mis datos a 300gb. Aunque es algo
tedioso es una buena opción para deshacernos de tantos archivos de
configuración de programas que ya no usamos.

Para borrar los datos busqué los directorios mas pesados, y dentro de
estos analicé sus subdirectorios para ver que generaba mas
espacio. El programa `du` es muy útil en estos casos, veamos un
ejemplo:

``` shell
du -xc --max-depth=1 | sort -n -r
```

Esto nos regresará una lista de los directorios de primer nivel
ordenados de mayor a menor. Ejecutando este comando en mi computadora,
dentro del directorio `/usr` obtengo lo siguiente:

``` shell
5410644 total
5410644 .
2507052 ./share
2053088 ./lib
673292  ./bin
73208   ./src
54644   ./include
46616   ./sbin
2740    ./games
```

Yo tengo un directorio `tmp` dentro de mi `home` que uso para
almacenar datos que no me importa conservar, por ejemplo, un respaldo
de una base de datos que voy a importar, que después de usarlo ya no
me interesa. Pero resulta que ese directorio con el tiempo va
creciendo por que no lo depuro, y ya tenía un tamaño considerable. En
estos casos se puede usar `find` para borrar archivos que tengan mas
de una semana:

    find ~/tmp -name "*" -mtime +8 -exec rm -f '{}' ';'
    
y esto lo podemos poner como una tarea del `cron` para que se ejecute
diariamente a las 4am:

    0 4 * * * find ~/tmp -name "*" -mtime +8 -exec rm -f '{}' ';'

### Archivos tar sin compresión

En este caso nuestro archivo `.tar` será casi idéntico en tamaño a
nuestros datos, pero con la ventaja de tener en un solo lugar todos
los archivos y preservando los permisos y fechas de creación. Para
crear el archivador solo tenemos que omitir las opciones `z` y `j`:

    tar cf respaldo.tar datos
    
Al no comprimir los datos se ahora una buena cantidad de tiempo.

### Archivos al vuelo

Esta técnica nos permite crear o mover un respaldo saltando pasos
intermedios, lo que en algunos casos nos ahorra espacio y en otros
tiempo. Algo que realizo con frecuencia, es conectarme a un servidor
remoto, crear un dump de una base de datos con alguna condición, lo
comprimo y después lo transfiero a mi computadora:

``` shell
# en el servidor
mysqldump my_big_database -w "where fecha > '2019-01-01'" -u mi_usuario -p >respaldo.sql
bzip2 respaldo.sql

# en mi equipo
scp some_sever:backup/respaldo.sql.bz2 .
```

Esto tiene algunos inconvenientes. Si la información a respaldar es
muy grande, el tiempo que tarda en finalizar el dump será
significativo, lo que implica estar pegados al equipo esperando a que
finalice. Aunado a esto, el archivo `respaldo.sql` será de gran
tamaño, y si no tengo mucho espacio en disco pudiera ser un
problema. Cuando por fin termina el dump, realizo la compresión del
archivo, lo cual también puede tomar mucho tiempo y es esperar
nuevamente. Esto lo podemos solucionar saltando la etapa de escribir
el archivo `respaldo.sql` para generar directamente la versión
comprimida:

    mysqldump my_big_database -w "where fecha > '2019-01-01'" -u mi_usuario -p | bzip2 >respaldo.sql.bz2

Ahora tenemos que esperar a que termine de crearse el archivo
`respaldo.sql.bz2` para transferirlo, pero `ssh` nos permite
redireccionar la salida de un comando como si estuviera en nuestro
equipo:

    ssh some_server 'mysqldump my_big_database -w "where fecha > \'2019-01-01\'" -u mi_usuario -p | bzip2' >respaldo.bz2

al hacer esto, el volcado de la base de datos es redirigido a `bzip2`,
y la salida de este (los datos comprimidos) en lugar de ser escritos a
un archivo viajan directamente por la red, y al llegar son
redireccionados finalmente a un archivo.

# Notas

* Es buena costumbre nombrar de forma inequívoca a los respaldos, por
  brevedad yo use un simple `respaldo.sql`, pero el nombre debe de ser
  lo suficientemente descriptivo e incluir la fecha de creación. Por
  ejemplo:

``` shell
mysqldump my_big_database orden_compra > orden_compra-$(date +%F).sql # esto generará "orden_compra-2019-06-03.sql"
```

* Otra buena práctica consiste en ordenar de manera lógica y/o
  cronológica la información en directorios. Por ejemplo:

``` shell
facturas/
|---> 2018/
    |----->01/
          |--->01-foobar.pdf
          |--->12-dummy.pdf
    |----->02/
          |--->05-lorem.pdf
```

en este caso, el número del nombre del archivo corresponde al día de
expedición de la factura. Con esta estructura aseguramos que los
archivos se muestren en el orden cronológico correcto, y además
podemos encontrar toda la información correspondiente a un periodo de
una manera muy rápida. Como un plus, esta jerarquía nos permite crear
scripts muy sencillos para navegar por el árbol de directorios, ya sea
para depurar o procesar archivos en concreto.
