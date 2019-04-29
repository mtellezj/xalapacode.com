+++
title = "Primeros pasos con python, fractales"
date = "2019-04-29T11:00:00-06:00"
draft = false
thumbnail = ""
description = "Recursión con python y la tortuga"
author = "categulario"
author_uri = "/directorio/categulario"
markup = "mmark"
+++

A todo esto, ¿Qué es la recursión? A continuación analizaremos con algunos ejemplos gráficos el concepto de _recursión_ y cómo puede ayudarnos a resolver algunos problemas.

## Un problema grande hecho de problemas más pequeños

Un problema típicamente recursivo se puede reconocer cuando en su estructura se puede pensar como problemas más pequeños similares entre si. Por ejemplo:

* Calcular un número en la secuencia de fibonacci donde el n-ésimo número es la suma del `n-1` y el `n-2`.
* Algunas búsquedas donde el mundo donde se está buscando se puede pensar en etapas y cada una es parecida a las demás en sus propiedades.
* Dibujar un fractal. Los fractales son por definición figuras autosimilares.

![Un fractal con forma de trébol](/img/blog/iniciando-con-python-fractales/trebol.png)

## Piezas de la recursión

Para comenzar a plantear un problema recursivo hay que pensar primero en sus estados más pequeños o finales. Por ejemplo al buscar un número de fibonacci puede ser calcular el fibonacci **0** o el fibonacci **1**, o en el caso de un fractal puede ser dibujar la forma más simple de la que está compuesto.

En el caso del bonito fractal del trébol de la imagen anterior, se puede observer que está hecho de tres _árboles_ similares entre si que se ven como éste:

![Una hoja del fractal del trébol](/img/blog/iniciando-con-python-fractales/trebol_una_hoja.png)

pero además si nos fijamos con más cuidado es posible ver que de hecho la figura básica de la que está hecho el trébol es esta:

![La figura básica del fractal del trébol](/img/blog/iniciando-con-python-fractales/figura_base.png)

## La víbora y la tortuga

Para comenzar a poner estas ideas un poco más cerca del contexto de la programación usaremos la tortuga de python, esta viene incluída por defecto en la mayoría de las instalaciones de python y es muy sencilla de utilizar. Abre una línea de comandos interactiva de python para empezar a probar:

{{< highlight python >}}
>>> from turtle import *
>>> home()
{{< / highlight >}}

Esto abrirá una ventana con una flecha en el medio, hay funciones que puedes utilizar para empezar a pintar, nosotros vamos a usar tres básicas: `forward`, `left` y `right` que sirven para avanzar y cambiar la dirección de la flecha. Puedes experimentar con ellas en la línea de comandos.

{{< highlight python >}}
>>> forward(100)
>>> left(60)
>>> forward(66)
>>> left(180)
>>> forward(66)
>>> left(60)
>>> forward(66)
{{< / highlight >}}

también es posible guardar el programa como un archivo y ejecutarlo sin usar una sesión interactiva:

{{< highlight python "linenos=table" >}}
# trebol.py
from turtle import *
home()
forward(100)
left(60)
forward(66)
left(180)
forward(66)
left(60)
forward(66)
exitonclick() # Sin esta función la tortuga se cerrará inmediatamente después de que termine de dibujar
{{< / highlight >}}

## Entrando en materia

Ahora que tenemos las herramientas necesarias podemos comenzar a construir la solución recursiva a nuestro problema. Lo primero es convertir el código que tenemos hasta ahora en una función pues de otra manera no lo podremos llamar recursivamente. Es muy importante separar las partes del código que se necesitan en cada paso de las que no se necesitan. Por ejemplo iniciar la tortuga con `home()` sucede una sola vez así que no necesita ser parte de la función recursiva, de la misma manera llamar `exitonclick()` no tiene nada que ver con la recursión.

{{< highlight python "linenos=table" >}}
from turtle import *

def hoja():
    forward(100)
    left(60)
    forward(66)
    left(180)
    forward(66)
    left(60)
    forward(66)

home()
hoja() # Hay que llamar a nuestra función, si no no pasa nada
exitonclick()
{{< / highlight >}}

Ese código no tiene ninguna diferencia funcional respecto al anterior. Ahora es momento de comenzar a pensar recursivamente. Cada vez que se dibuja una línea, dos más pequeñas deben ser dibujadas en uno de sus extremos y luego cuatro más pequeñas en sus respectivos extremos etcétera. Para hacerlo más simple pensemos primero en la línea que brota de la izquierda y tratemos de dibujarla. Podemos modificar la función para dibujar esta línea:

{{< highlight python "linenos=table" >}}
def hoja():
    # tallo
    forward(100)
    # Comienzan las ramas
    left(60)
    forward(100*(2/3))
    # dibujamos una rama más pequeña
    left(60)
    forward(100*(2/3)**2)
{{< / highlight >}}

si utilizas esta función `hoja()` verás un resultado como el que se muestra en la siguiente imagen, que ya va teniendo un poco más de forma.

![Ramas izquierdas](/img/blog/iniciando-con-python-fractales/ramas_izquierdas.png)

Otras cosas pasaron en este código. Para ir haciendo las líneas cada vez más cortas las estamos reduciendo en 2/3 para cada siguiente rama. En la siguiente tabla se muestran las longitudes de cada tramo.

{.table-container}
| Paso | Valor deseado | Equivalente algebráico | Valor calculado |
| --------- | --------- | ---------| -------- |
| 1 | 100 | 100 * (2/3)**0 | 100 |
| 2 | 100 * 2/3 | 100 * (2/3)**1 | 66.66 |
| 3 | (100 * 2/3) * 2/3 | 100 * (2/3)**2 | 44.44 |

¿Bonito no? Podemos utilizar estas propiedades matemáticas para hacer una función recursiva que haga todas las ramas de la izquierda, solo tenemos que llevar un registro de cuántos pasos hemos hecho para ir calculando las longitudes correspondientes. Otra cosa importante es notar que en el código de la función suceden las mismas instrucciones pero con diferentes argumentos, así que podemos reemplazarlas por una llamada recursiva.

{{< highlight python "linenos=table" >}}
def hoja(profundidad=0):
    forward(100 * (2/3)**profundidad)
    left(60)
    hoja(profundidad+1)
{{< / highlight >}}

¿Qué pasa cuando ejecutamos nuestro programa con esa función `hoja()`?

![Rama izquierda recursiva](/img/blog/iniciando-con-python-fractales/recursion_infinita.png)

Si ves algo como la imagen anterior habrás notado también que se queda dando vueltas por algún tiempo y con la paciencia necesaria fallará con un error como este:

{{< highlight text >}}
RecursionError: maximum recursion depth exceeded in __instancecheck__
{{< / highlight >}}

Hemos cometido uno de los errores más comunes en la recursión que es no definir un límite. Esta condición es peligrosa por que puede acabar con la memoria disponible de un programa y este programa terminará inevitablemente. Tradicionalmente al escribir una función recursiva hay que pensar primero en cuál va a ser su límite o _condición de salida_ y escribirlo desde el principio, pero aquí hemos querido experimentar.

En el caso de nuestro pequeño programa podemos observar que la variable `profundidad` va aumentando y que una vez que es demasiado grande no se notan las líneas que se dibujan por lo cortas que son. Esta variable puede ser un buen indicador de cuándo ya no tiene sentido seguir dibujando y parar la recursión.

{{< highlight python "linenos=table" >}}
def hoja(profundidad=0):
    if profundidad > 3:
        # Establecemos una condición con un valor experimental,
        return

    forward(100 * (2/3)**profundidad)
    left(60)
    hoja(profundidad+1)
{{< / highlight >}}

Podemos pensar en una ejecución del código anterior con el código _desenvuelto_ de la siguiente manera:

{{< highlight python "linenos=table" >}}
# def hoja(profundidad=0):
# if 0 > 3: return
forward(100 * (2/3)**0)
left(60)

# hoja(0+1)
# if 1 > 3: return
forward(100 * (2/3)**1)
left(60)

# hoja(1+1)
# if 2 > 3: return
forward(100 * (2/3)**2)
left(60)

# hoja(2+1)
# if 3 > 3: return
forward(100 * (2/3)**3)
left(60)

# hoja(3+1)
if 4 > 3:
    return
{{< / highlight >}}

Ahora toca pensar en cómo dibujar las ramas del lado derecho. Aquí viene un reto interesante por que la tortuga, luego de dibujar cada rama está al final de la misma y las ramas del lado derecho comienzan donde termina la anterior. Básicamente eso significa que tenemos que "regresar" y eso significa escoger en qué momento del código hacer ese "regreso". Analizemos con cuidado distintas alternativas.

{{< highlight python "linenos=table" >}}
def hoja(profundidad=0):
    # No se debería poner nada antes de la salida de la recursión, así que este
    # no es el lugar correcto
    if profundidad > 3:
        return

    forward(100 * (2/3)**profundidad)
    # Acabamos de dibujar una línea y estamos por girar a la izquierda, no es
    # el lugar correcto
    left(60)
    # Apenas giramos a la izquierda, no es el lugar correcto
    hoja(profundidad+1) # La llamada recursiva
    # Queda este hueco pero ¿Cuándo se llamaría una función escrita aquí?
{{< / highlight >}}

para entender bien este paso vamos a ver unos ejemplos.

{{< highlight python >}}
def foo():
    print("foo")

def bar():
    print("bar antes de foo")
    foo()
    print("bar después de foo")

bar()
{{< / highlight >}}

## Los peligros de la recursión

Describir cómo se ve la memoria de un programa recursivo
