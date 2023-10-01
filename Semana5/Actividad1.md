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

### Sesión

Ambas aplicaciones garantizan que el juego actual se cargue desde la sesión antes de que se produzca cualquier acción del controlador y que el juego actual (posiblemente modificado) se reemplace en la sesión después de que se complete cada acción.

1. En la versión de Sinatra, los bloques `before do...end` y `after do...end` se utilizan para la gestión de sesiones. ¿Cuál es el equivalente más cercano en esta aplicación Rails y en qué archivo encontramos el código que lo hace?
2. Un formato de serialización popular para intercambiar datos entre aplicaciones web es JSON. ¿Por qué no funcionaría utilizar JSON en lugar de YAML? (Sugerencia: intenta reemplazar `YAML.load()` con `JSON.parse() y `.to_yaml` con `.to_json` para realizar esta prueba. Tendrás que borrar las cookies asociadas con `localhost:3000` o reiniciar tu navegador con un nueva Ventana de navegación privada, para borrar `session[]`. Según los mensajes de error que recibes al intentar utilizar la serialización JSON, deberías poder explicar por qué la serialización YAML funciona en este caso pero JSON no).

### Vista

1. En la versión de Sinatra, cada acción del controlador termina con una redirección (que, como puedes ver, se convierte en `redirect_to` en Rails) para redirigir al jugador a otra acción, o con `erb` para representar una vista. ¿Por qué no hay llamadas explícitas correspondientes a `erb` en la versión Rails? (Sugerencia: según el código de la aplicación, ¿puede discernir la regla de convención sobre configuración que funciona aquí?).
2. En la versión de Sinatra, codificamos directamente un formulario HTML usando la etiqueta `<form>` mientras que en la versión de Rails usamos un método Rails `form_tag` aunque sería perfectamente legal usar etiquetas `HTML <form>` sin formato en Rails. ¿Se te ocurre alguna razón por la que Rails podría introducir este "nivel de direccionamiento indirecto"?
3. ¿Cómo se manejan los elementos del formulario, como campos de texto y botones, en Rails? (Nuevamente, el HTML sin formato sería legal, pero ¿cuál es la motivación detrás de la forma en que Rails lo hace?)
4. En la versión de Sinatra, las vistas `show`, `win` y `lose` reutilizan el código en la nueva vista que ofrece un botón para iniciar un nuevo juego. ¿Qué mecanismo de Rails permite reutilizar esas vistas en la versión de Rails?.

### Cucumber

Los escenarios de Cucumber y las definiciones de pasos (todo lo que se encuentra en `features/`, incluido el soporte para `Webmock` en `webmock.rb`) se copiaron palabra por palabra de la versión de Sinatra, con una excepción: el archivo `features/support/env.rb` es más simple porque la gema `cucumber-rails` hace automáticamente algunas de las cosas que teníamos que hacer explícitamente en ese archivo para la versión de Sinatra.

Verifica la ejecución de los escenarios de Cucumber y páselos ejecutando `rake cucumber`.

1. ¿Cuál es una explicación cualitativa de por qué no fue necesario modificar los escenarios de Cucumber y las definiciones de pasos para que funcionaran igualmente bien con las versiones de la aplicación Sinatra o Rails?.
