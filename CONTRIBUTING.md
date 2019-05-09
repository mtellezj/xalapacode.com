# Cómo contribuir a este proyecto

## Usando git

* **Crea un fork**. En github/gitlab visita la URL del proyecto y busca el botón que dice **fork**.
* **Clona el fork**. En github/gitlab ve a tu fork, busca el botón **clonar**, copia la URL y escribe en la terminal `git clone <pegas la url>`.
* **Entra a la carpeta** del proyecto recién clonado en la terminal.
* **Añade el remoto upstream**. En github/gitlab navega al repositorio original (del que hiciste fork), busca el botón **clonar**, copia la URL y escribe en la terminal `git remote add upstream <pegas la url>`.
* **Crea una rama** antes de empezar a escribir código. Llámala como los cambios que vas a hacer. Puedes crear una rama usando `git checkout -b <nombre de la rama> master`. Los nombres de las ramas deberían ser en minúsculas y sin espacios, puedes usar `/` y `-`.
* **Haz cambios** ¡Hora del código! Juega con el proyecto, haz y deshaz a placer, ve haciendo commits con tu progreso.
* **Sube tus cambios**. Si estás convencid@ de que tus cambios están listos súbelos usando `git push -u origin <nombre de la rama en la que estás>`. Puedes hacer más commits y subir mas cambios usando solamente `git push`.
* **Haz un pull/merge-request**. En github/gitlab ve a tu fork y usa el botón **crear pull/merge request**, añade una descripción de por qué los cambios son relevantes.
* **Actualiza tu rama master**. Si tus cambios son aprobados (o si hay cambios de otras personas en el repositorio original) puedes bajarlos cambiando primero a la rama master (`git checkout master`) y luego bajando los cambios con `git pull upstream master`.
* (opcional) **Actualiza tu rama** Si tienes una rama en desarrollo y acabas de bajar cambios de `upstream` puedes (y quizá debes) actualizar tu rama cambiando a esta (`git checkout <nombre de la rama>`) y ejecutando `git merge master`.
* **Borra tus ramas terminadas**. Cuando el trabajo está hecho (los cambios fueron unidos en master o la rama ya no es útil) bórrala cambiando primero a `master` y luego ejecutando `git branch -d <nombre de la rama>`.

### Es importante recordar

* Cambios distintos van en ramas distintas, por ejemplo si quieres hacer dos cosas: resolver un bug e implementar una característica deberías crear una rama para el bug y una para la característica.
* No hagas commits en tu rama máster, todo commit que hagas debe estar en una rama específica de la funcionalidad que vayas a desarrollar
