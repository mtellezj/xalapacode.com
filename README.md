# sitio web xalapacode.com

## Contribuyendo al sitio web

1. Instala y configura [Hugo](http://gohugo.io/)
1. Haz fork de este repo https://github.com/XalapaCode/xalapacode.com/
1. Clona tu fork (`git clone https://github.com/tu/elfork.git`)
1. Crea una nueva rama desde master (`git checkout -b nombre-de-la-rama`)
1. Haz la contribución (y commits)
1. Sube tu branch (`git push -u origin nombre-de-la-rama`) y crea el PR
1. Espera por la aprobación y merge de algun administrador
1. Espera por el despliegue a https://xalapacode.com
1. Actualiza tu rama `master` con los cambios remotos
  - cambia a la rama master (`git checkout master`)
  - agrega el repositorio principal a tus remotos (este solo lo necesitas correr una vez por cada repositorio local) `git remote add upstream https://github.com/XalapaCode/xalapacode.com.git`
  - actualiza tu rama `master` local `git pull upstream master`
1. borra tu rama, los cambios ya están en `master`
  - `git branch -d nombre-de-la-rama`

## Construyendo el proyecto

`make`

Esto construye el sitio y los estilos. Más abajo se detalla al respecto.

## Formas de contribución

### De contenido

Actualmente el sitio esta dividido en 6 secciones principales (eventos, platicas, bolsa de trabajo, patrocinadores, directorio y blog) que pueden ser editadas por los miembros de la comunidad y 1 pagina (acerca de) que solo puede ser editada por los administradores.

Si desean añadir nuevo contenido o corregir el existente este se encuentra en la carpeta `content` que esta en el directorio raiz.

Cada carpeta tiene un archivo example.md que describe cual es el formato esperado para cada tipo de contenido. Notese que hay un campo `draft = true` que evita que el contenido se muestre en las paginas correspondientes.

### De imagenes

Todas las imagenes deben ir en la carpeta `static/img/` en la respectiva carpeta

### De estilos

Las carpetas de estilos y scrips se encuentran en `themes/xalapacode/static`, te recomendamos instalar sass ya sea con Ruby o Node de forma global, de esa forma podras utilizar el comando `make` para generar el sitio o el comando `sass scss/main.scss:css/main.css` dentro de la carpeta `themes/xalapacode/static` y de esta forma podrás visualizar los cambios de estilos.

El sitio usa Sass con extensión `.scss` y esta organizado de la siguiente manera:

* Base
* Helpers
* Components
* Layout
* Pages
* Themes
* Vendors

Actualmente solo se estan utilizando las primeras 5 carpetas para los estilos. Si desea corregir un bug en estilos hágalo sobre estas carpetas.

#### Sobre paginas personalizadas para miembros del directorio

Cada miembro en el directorio puede personalizar los estilos de su pagina de perfil creando un nuevo archivo scss cuyo nombre sera el nickname del miembro en la carpeta `pages` y donde la clase contenedora sea su nickname.

## Sobre el sitio

El sitio esta construido con [Hugo](http://gohugo.io/) y esta licenciado bajo [Creative Commons Atribución 4.0 Internacional](http://creativecommons.org/licenses/by/4.0/)
