## AJAX: Asynchronous JavaScript y XML

Presenta un repositorio de tus respuestas llamado `Ajax` y utiliza el siguiente proyecto: https://github.com/kapumota/Desarrollo-software-2023/tree/main/Semana8/myrottenpotatoes.

Indicamos los pasos necesarios para la programación `AJAX on Rails`: 

1. Crear una acción del controlador o modificar una existente para gestionar las peticiones AJAX hechas por el código JavaScript.
   En lugar de procesar una vista completa, la acción procesará una parcial para generar un fragmento HTML que se insertará en la página. 

2. Construir un URI REST en JavaScript y utilizar XHR (XmlHttpRequest) para enviar la petición HTTP al servidor.
   Como habrás supuesto, jQuery dispone de atajos útiles para muchos casos habituales, por lo que utilizaremos las funciones de más alto nivel y más potentes que ofrece jQuery en lugar de llamar a XHR directamente. 

3. Dado que JavaScript, por definición, se ejecuta en un hilo único (single-threaded ), sólo puede trabajar en una tarea cada vez hasta que dicha tarea se completa, la interfaz de
   usuario del navegador se quedaría `congelada` mientras JavaScript esperara la respuesta del servidor. Por ello, XHR en cambio vuelve inmediatamente de la llamada a la función y
   permite proporcionar una función callback para manejar el evento que se activará cuando responda el servidor o si se produce un error. 

4. Cuando la respuesta llega al navegador, el contenido de la respuesta se pasa a la función callback. Puede utilizar la función `replaceWith()` de jQuery para reemplazar un elemento
    existente por completo, `text()` o `html()` para actualizar el contenido de un elemento in situ o una animación como `hide()` para ocultar o mostrar elementos.
   Puesto que las funciones JavaScript son clausuras (como los bloques de Ruby), la función `callback` tiene acceso a todas las variables visibles en el momento en el que se
   realizó la llamada XHR, aun cuando se ejecuta más tarde y en un entorno distinto. 

