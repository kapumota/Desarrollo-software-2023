### Depuración SaaS que usan Rails

En las aplicaciones SaaS que usan Rails, esta confusión se puede agravar si la operación que falló ocurre en una acción del controlador, pero el objeto inválido se pasó como una
variable de instancia y luego fue dereferenciada en la vista, como se muestra en los siguientes extractos de un controlador y una vista:

```
# in controller action:
def show
  @movie = Movie.find_by_id(params[:id]) # what if this movie not in DB?
  # BUG: we should check @movie for validity here!
end
-# ...later, in the Haml view:

%h1= @movie.title
-# will give "undefined method 'title' for nil:NilClass" if @movie is nil
```
- Pregunta (Ask) Si estás en un entorno de trabajo de "puestos no asignados", o tiene activada la mensajería instantánea, distribuye el mensaje ahí fuera.
- Busca (Search) el mensaje de error. Te sorprenderías las veces que los desarrolladores con experiencia se enfrentan a un error buscando en un motor de búsqueda como Google
palabras clave o frases clave del mensaje de error. También puedes buscar en sitios como StackOverflow , que se especializan en ayudar a los desarrolladores y te permiten votar las
respuestas más útiles a una pregunta particular, para que eventualmente vayan pasando a la parte más alta de la lista de respuestas.

- Postea (Post) una pregunta a uno de esos sitios si todo lo demás falla. Selo más específico posible acerca de lo que fue mal, cuál es tu entorno y cómo reproducir el problema:
  - Vago: "La gema sinatra no funciona en mi sistema". No hay suficiente información aquí para que alguien pueda ayudarte.
  - Mejor, pero irritante: "La gema sinatra no funciona en mi sistema. Adjunto el mensaje de error de 85 líneas”. Los otros desarrolladores están tan ocupados como tu y probablemente no van a perder tiempo extrayendo la información relevante de esa traza tan larga.
- Lo mejor: Mira la transcripción real de esta pregunta en StackOverflow. A las 6:02pm, el desarrollador ofreció información específica, como el nombre y la versión de su sistema operativo, los comandos específicos que ejecutó satisfactoriamente, y el error inesperado que obtuvo. Otras voces serviciales le preguntaron información adicional específica y sobre las 7:10pm, dos de las respuestas habían identificado el problema.

 Aquí hay algunas cosas que se pueden intentar si la aplicación se detiene:

- Aprovechar la indentación automática y el marcado de sintaxis.
- Mira el `log file` por lo general `log/development.log`, para obtener una información más completa del error, incluyendo la traza. En las aplicaciones en producción, ésta suele ser la unica alternativa, porque las aplicaciones Rails en modo producción están configuradas para mostrar una página de error más amigable de cara al usuario, en vez de mostrar la traza del error que verías si éste ocurriese en modo desarrollo.

En el segundo tipo de problema, la aplicación se ejecuta pero tiene un resultado o comportamiento incorrecto. Muchos desarrolladores usan la combinación de dos enfoques para depurar este tipo de problemas. El primero es insertar sentencias extra de instrumentación para registrar valores de variables importantes en varios puntos durante la ejecución de programa. Hay varios lugares donde podemos instrumentar una aplicación SaaS en Rails. Prueba cada uno  para experimentar cómo funcionan:

- Muestra la descripción detallada de un objeto en una vista. Por ejemplo, pruebA a insertar `= debug(@movie)` o `= @movie.inspect` en cualquier vista (donde el signo
`=` le dice a Haml que ejecute el código e inserta el resultado en la vista).
- Detien la ejecución dentro de un método de un controlador lanzando una excepción cuyo mensaje sea una representación del valor que quieres inspeccionar, por ejemplo, `raise params.inspect`
- Para ver el valor detallado de la hash `params` dentro del método de un controlador. Rails desplegará el mensaje de la excepción como la página web resultante de la petición.
- Usa `logger.debug( mensaje)` para imprimir el mensaje al fichero de logging. `logger` está disponible en los modelos y en los controladores y puede registrar mensajes con
distintos niveles de importancia. Compara `config/environments/production.rb` con `development.rb` para ver cómo difieren los niveles logs por defecto entre
los entornos de producción y desarrollo.

La segunda forma de depurar los problemas es con un depurador interactivo. 
Instala la gema `debugger` a través de Gemfile, para usar el depurador en una aplicación Rails. 

Arranca el servidor de la aplicación usando  `rails server --debugger`, e inserta la sentencia `debugger` en un punto del código donde desees y detiene el programa. Cuando
llegas a esa sentencia, la ventana del terminal donde arrancó el servidor te dará el prompt del depurador. 

Realiza esto.
