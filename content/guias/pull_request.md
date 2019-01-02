---
title: "¿Cómo hacer un pull request?"
date: 2019-01-02T15:18:14-06:00
draft: false
description: "Guía paso a paso para contribuir."
author: "@Categulario"
---

¿Así que quieres contribuir a un proyecto? Básicamente los pasos son los siguientes:

1. [Haz fork](#haz-fork)
2. [Clona tu fork a tu computadora](#clona-tu-fork-a-tu-computadora)
3. [Crea una rama](#crea-una-rama)
4. [Modifica el código fuente](#modifica-el-código-fuente)
5. [Publica tus cambios](#publica-tus-cambios)
6. [Haz pull request](#haz-pull-request)
7. [Actualiza tu proyecto con los últimos cambios](#actualiza-tu-proyecto-con-los-últimos-cambios)

## Haz fork

Un *fork* es una réplica de un repositorio en tu propia cuenta de github/gitlab. Te permiten acceder al código y editarlo sin que eso genere un nuevo miembro con acceso de escritura para los creadores originales. Es la forma más conveniente de contribuir al open source.

Para crear un fork, navega a la dirección del repositorio y haz click en en botón arriba a la derecha que dice *fork*.

{{<figure src="/img/guias/pull_request/fork.png" title="Botón de fork" >}}

## Clona tu fork a tu computadora

En la página de tu fork, copia la URL para clonar el proyecto:

{{<figure src="/img/guias/pull_request/clone.png" title="Url para clonar" >}}

Utiliza esta URL para clonar el proyecto en tu computadora. Si usas la terminal sería:

```
$ git clone https://github.com/categulario/xalapacode.com.git
```

Nótese que esta es la URL de mi propio fork, la URL que tu debes usar tiene tu nombre de usuario.

## Crea una rama

Es de vital importancia que las modificaciones que hagas las hagas en una rama, y si haces muchas modificaciones que tienen que ver con cosas distintas (por ejemplo unos son características y otras son correción de errores) las pongas en ramas distintas.

```
$ git checkout -b mejoras-de-usabilidad
```

Trata de que el nombre de la rama indique qué es lo que está cambiando en el código. En el ejemplo anterior `mejoras-de-usabilidad` es el nombre de la rama.

**¡Recuerda no crear commits en la rama máster de un proyecto del que no eres colaborador con permiso de escritura!**

## Modifica el código fuente

¡Esta es la mejor parte! Haz tu mejor esfuerzo por escribir código limpio y acorde a las guías de estilo del proyecto. Ver cómo está escrito otro código similar puede ser de ayuda. Haz commits descriptivos de cada cosa que cambies, agregues o elimintes.

## Publica tus cambios

Cuando estés listo para publicar tus cambios haz:

```
git push -u origin mejoras-de-usabilidad
```

recuerda que la última parte (`mejoras-de-usabilidad`) es el nombre de la rama de ejemplo. Usa el nombre que le hayas dado a tu rama. La bandera `-u` significa `--set-upstream` que va a relacionar la rama local con la rama remota.

## Haz pull request

Llegó la hora de la verdad. Visita la página de tu fork (https://github.com/tuusuario/repositorio) y si acabas de hacer push verás una recomendación de hacer pull request. Da click en el botón:

{{<figure src="/img/guias/pull_request/pull-request.png" title="Botón de pull request" >}}

Finalmente llena el formulario con comentarios adicionales acerca de por qué crees que ese cambio es necesario o algún recurso que quieras citar y presiona **Crear pull request**.

{{<figure src="/img/guias/pull_request/create-pull-request.png" title="Enviar el pull request" >}}

A partir de aquí los cambios están en manos de los administradores, solo queda esperar por el **merge** o por comentarios adicionales. Si necesitaras añadir más cambios al mismo pull request solo tienes que hacer más commits en esa rama y hacer push.

## Actualiza tu proyecto con los últimos cambios

Este paso no es necesario para crear un pull-request, pero sí es necesario si vas a contribuir continuamente en un proyecto.

Deberías considerar añadir un nuevo **origen** para tu repositorio con la URL del proyecto original. Navega al proyecto original y copia la URL de clonado. Luego en la terminal (y en la carpeta del proyecto) haz:

```
$ git remote add upstream https://github.com/xalapacode/xalapacode.com.git
```

Ahora estás listo para actualizar el proyecto:

```
$ git checkout master
$ git pull upstream master
```

Esto dejará tu rama máster actualizada con los últimos cambios. Ahora solo falta actualizar tus ramas locales si aun existen.

```
$ git checkout rama-en-progreso
$ git merge master
```

¡Listo!
