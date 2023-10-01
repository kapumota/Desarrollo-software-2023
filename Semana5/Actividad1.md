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
3. Para la mayoría de las aplicaciones Rails, también tendrías que crear y inicializar la base de datos de desarrollo, pero al igual que la aplicación Sinatra, esta aplicación no utiliza ninguna base de datos.
Juega con el juego para convencerte de que funciona igual que la versión de Sinatra.

### Dónde están las cosas

Ambas aplicaciones tienen una estructura similar: el usuario activa una acción en un juego mediante una solicitud HTTP. Se llama a un fragmento particular de código para "manejar" la solicitud según corresponda, se llama a la lógica de la clase `WordGuesserGame` para manejar la acción y normalmente, se representa una vista para mostrar el resultado. 

Pero las ubicaciones del código correspondiente a cada una de estas tareas son ligeramente diferentes entre Sinatra y Rails.

1. ¿En qué parte de la estructura del directorio de la aplicación Rails está el código correspondiente al modelo `WordGuesserGame`?
2. ¿En qué archivo está el código que más se corresponde con la lógica del archivo `app.rb` de las aplicaciones Sinatra que maneja las acciones entrantes del usuario?
3. ¿Qué clase contiene ese código?
4. ¿De qué otra clase (que es parte del framework Rails) hereda esa clase?
5. ¿En qué directorio está el código correspondiente a las vistas de la aplicación Sinatra (`new.erb`, `show.erb`, etc.)?
6. Los sufijos de nombre de archivo para estas vistas son diferentes en Rails que en la aplicación Sinatra. ¿Qué información proporciona el sufijo situado más a la derecha del nombre del archivo (por ejemplo: en `foobar.abc.xyz`, el sufijo `.xyz`) sobre el contenido del archivo?
7. ¿Qué información te brinda el otro sufijo sobre lo que se le pide a Rails que haga con el archivo?
8. ¿En qué archivo está la información de la aplicación Rails que asigna rutas (por ejemplo, `GET/new`) a las acciones del controlador?
9. ¿Cuál es el papel de la opción `:as => 'name'` en las declaraciones de ruta de `config/routes.rb`? (Pista: mira las vistas).
