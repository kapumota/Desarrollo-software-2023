## Sinatra y Rails

En una tarea anterior, creaste una aplicación web sencilla que juega `Wordguesser`.

De manera específica:

1. Escribiste el código de la aplicación en la clase `WordGuesserGame` que no sabe nada acerca de ser parte de una aplicación web.
2. Utilizaste el framework de trabajo de Sinatra para "envolver" el código del juego proporcionando un conjunto de acciones RESTful que el jugador puede realizar con las siguientes rutas:

  - `GET/new`: pantalla predeterminada ("home") que permite al jugador comenzar un nuevo juego
  - `POST /create`:crea el nuevo juego
  - `GET /show`: muestra el estado actual del juego y permite al jugador realizar un movimiento.
  - `POST /guess`:el jugador envía una carta adivinada
  - `GET /win`: redirigido aquí cuando la acción del programa detecta que el juego se ganó
  - `GET/lose`: redirigido aquí cuando la acción del programa detecta que el juego se perdió

3. Para mantener el estado del juego entre solicitudes HTTP (sin estado), se almacenó una copia de la instancia de `WordGuesserGame` en el hash de `sesion[]` proporcionado por Sinatra, que es una abstracción para almacenar información en cookies que se pasan de un lado a otro entre la aplicación y el navegador del jugador.

En esta tarea, reutilizarás el mismo código del juego pero lo **envolverás** en una aplicación Rails simple en lugar de en Sinatra.

### Ejecuta la aplicación

Puede resultarte útil tener a mano estas [guías de Rails](https://guides.rubyonrails.org/v4.2/) y la [documentación de referencia](https://api.rubyonrails.org/v4.2.11/) de Rails.

Como todas las aplicaciones Rails, puedes ejecutar esta siguiendo estos pasos:

1. Clona el repositorio de tareas.
  ```
    git clone https://github.com/saasbook/hw-rails-wordguesser.git
  ```
2.Cambia al directorio raíz de la aplicación `hw-rails-wordguesser`

3.Ejecuta `bundle install --without production`

4. Inicia el servidor:
  Cuando se ejecuta en una computadora local, simplemente puedes ejecutar  `rails server`.

### Preguntas 

1. ¿Cuál es el objetivo de ejecutar `bundle install`?
2. ¿Por qué es una buena práctica especificar `--without production` al ejecutarlo en tu computadora de desarrollo?
3. (Para la mayoría de las aplicaciones Rails, también tendrías que crear y inicializar la base de datos de desarrollo, pero al igual que la aplicación Sinatra, esta aplicación no utiliza ninguna base de datos).
Juega con el juego para convencerte de que funciona igual que la versión de Sinatra.

