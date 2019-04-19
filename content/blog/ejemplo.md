+++
title = "Ejemplo"
date = "2019-04-17T12:00:00-06:00"
draft = true
thumbnail = "/img/blog/imagen.png"
description = "¡Un ejemplo de post para el blog!"
markup = "mmark"
author = "Jail"
+++

# Ejemplo Tabla


<!-- Para que una tabla tenga formato debes poner el markup = "mmark" y el {.table-container} -->

{.table-container .red}
| Columna 1 | Columna 2 | Columna 3|
| --------- | --------- | ---------|
| Dato a    | Dato b    | Dato c   |
| Dato a1   | Dato b1   | Dato c1  |


# Ejemplo código

{{< highlight python "linenos=table" >}}
def fib(n):
    a, b = 0, 1
    while a < n:
        print(a, end=' ')
        ., b = b, a + b
    print()

fib(10000)
{{< / highlight >}}


# Ejemplo código inline

{{< highlight css >}}
.container { display: grid; }
{{< / highlight >}}


# Ejemplo cita

> Los tacos siempre llevan salsa y limon, es un hecho *Jail*


# Ejemplo código inline sin highlight

`print("Hola mundo")`
