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

Objetivo: Tu tarea es implementar las partes del archivo denominado `TU CODIGO AQUI`. La referencia que contiene las soluciones se encuentra en el archivo `final.rb`.

### Parte 1

Lo primero que vamos a hacer es crear un modelo. A diferencia de Rails, Sinatra no tiene MVC integrado, así que vamos a piratear el nuestro. Usaremos `ActiveRecord` sobre una base de datos SQLite. En esta aplicación, ¿cuál será nuestro modelo y qué operaciones CRUD le aplicaremos?

- index:
- create:
- read:
- update:
- destroy

### Parte 2

A continuación, creemos algunas rutas para que los usuarios puedan interactuar con la aplicación. Aquí hay una URL de ejemplo:

```
  https://www.etsy.com/search?q=test#copy
```
Primero, especifica qué partes de la URL son  componentes según la discusión sobre la forma de una URL. Consulta esta publicación de [IBM](https://www.ibm.com/docs/en/cics-ts/5.1?topic=concepts-components-url) que detalla los componentes de una URL.

- https:// :
- etsy :
- 443 :
- /search :
- q=test :
- copy :

En Sinatra, el enrutamiento y el controlador están acoplados, lo que facilita la declaración de rutas. Declaramos algunas rutas RESTful para que podamos ver una lista de tareas pendientes, crear una tarea pendiente, editar una tarea pendiente y eliminar una tarea pendiente. ¿Qué acciones RESTful deberíamos utilizar para estos?

### Parte 3

Dado que HTTP es un protocolo RESTful, cada solicitud debe ir seguida de una respuesta, por lo que debemos devolver una vista o redirigir a cada solicitud. Usaremos JSON para las respuestas, que es similar a lo que hacen muchas API. ¿Hacia dónde debería ir la respuesta?.
