## Demostración de MVC, rutas RESTful y CRUD con Sinatra 


### Instrucciones

En esta sección veremos cómo aplicar ideas de MVC, RESTful Routes y CRUD en el contexto de Sinatra para crear una aplicación de lista de tareas pendientes. 
Cuando hayas terminado, los usuarios deberían poder ir a tu sitio web, ver su lista de tareas pendientes, crear nuevos elementos de la lista, editar elementos de la lista y eliminar elementos de la lista.

Construiremos el código base, con el código de inicio ubicado dado en el repositorio de la actividad. Aquí está la referencia a [Sinatra](https://sinatrarb.com/intro.html) ¡que será útil!.

Presenta esta tarea individual en un repositorio llamado MVC-Restful, CRUD con evidencia del proceso dado. Puedes trabajar en equipo para resolver los ejercicios.

### Configuración

```
  cd sinatra-intro/
  bundle install
  ruby template.rb # O: bundle exec ruby template.rb
```

Luego, ingresa el siguiente enlace en un navegador para ver la página web y verificar si está funcionando.

```
  http://localhost:4567/todos
```

Además, prueba el siguiente comando usando 'curl' para verificar que la aplicación se esté ejecutando localmente y responda. El comando activa una solicitud `GET` para recuperar la lista de "cosas por hacer" y debería recibir una respuesta que se muestra en la salida estándar de la línea de comando.

```
  curl http://localhost:4567/todos
```

En los siguientes ejercicios, agregaremos más rutas y podrás continuar usando comandos curl con diferentes argumentos para verificar la corrección de sus comportamientos.

Objetivo: Su tarea es implementar las partes del archivo denominado "SU CÓDIGO AQUÍ". La referencia que contiene las soluciones se encuentra en el archivo final.rb.
