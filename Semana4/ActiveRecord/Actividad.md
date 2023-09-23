## Conceptos básicos de ActiveRecord

Para esta actividad, hemos creado una base de datos de 30 clientes falsos, con nombres falsos, direcciones de correo electrónico falsas y fechas de nacimiento falsas 
(cortesía de [Faker gem](https://github.com/faker-ruby/faker)) y escribirás varias consultas de ActiveRecord para extraer y/o actualizar subconjuntos de estos clientes.

Como beneficio adicional, obtendrás más experiencia utilizando las **pruebas continuas**, en las que cada vez que realiza un cambio en el código o las 
pruebas, se vuelve a ejecutar automáticamente un conjunto completo de pruebas automatizadas. De esta manera, puedes entrar en un ritmo de codificación y pruebas sin volver a 
ejecutar manualmente las pruebas proporcionadas para ver si tu código es correcto.

Los archivos de esta tarea son:

- `lib/activerecord_practica.rb`, donde completarás su código. En proyectos Ruby que no son Rails (gemas, aplicaciones independientes, etc.), `lib` es donde normalmente residen los archivos de código.
- `spec/activerecord_practica_spec.rb` (`specfile`), que contiene pruebas RSpec que verificarán el resultado de cada consulta que escribas.
- `customer.sqlite3`, la base de datos que contiene los clientes falsos. (`customers-original.sqlite3` es solo una copia de seguridad, en caso de que necesites restaurar tu base de datos).
- `customers.csv`, una versión de la lista de clientes que puedes abrir en Excel o Google Sheets si deseas verificar manualmente sus resultados
- `Guardfile`, para permitir la ejecución automática de pruebas: cada vez que realizas un cambio en tu archivo, las pruebas se vuelven a ejecutar automáticamente.
- `Gemfile` y `Gemfile.lock`  como siempre archivos de configuración.


**SQL**

Si nunca antes has trabajado con bases de datos relacionales, te recomendamos que obtengas algunos conocimientos básicos. Un excelente recurso gratuito para aprender los conceptos 
básicos de SQL es el tutorial de [SQL de Khan Academy](https://www.khanacademy.org/computing/computer-programming/sql). 

Una alternativa es [SQLTutorial.org](https://www.sqltutorial.org/), secciones 1-4, 11 y 13.

**Preparación**

- En el directorio de nivel superior de la tarea, ejecuta `bundle` para asegurarse de tener las gemas necesarias.

#### Información de contexto

Tu objetivo es escribir consultas de ActiveRecord en la base de datos de clientes falsa cuyo esquema es el siguiente:

- `first`, `last` (nombre y apellido): String
- `email`: string
- `birthday`: Datatime

Cada consulta que escribas estará "envuelta" en su propio método de `class Customer < ActiveRecord::Base`, que se define en `activerecord_practica.rb`.

Sin embargo, no ejecutes este archivo directamente. En su lugar, utilizarás el archivo de especificación (specfile), que contiene una prueba para cada una de las consultas que debe escribir.

- Ejecuta el archivo de prueba una vez con `bundle exec rspec spec/activerecord_practice_spec.rb`. (Recuerda que `bundle exec` es necesario para garantizar que las versiones
  correctas de las gemas requeridas se carguen y activen correctamente antes de ejecutar el código). El resultado debe ser `13 ejemplos, 0 fallas, 13 pendientes`.

Hemos configurado las pruebas para que inicialmente se omitan todas las pruebas. (Todos fallarían porque aún no has escrito el código para ellos). 
Abre el specfile  y echa un vistazo. tu flujo de trabajo será el siguiente:

1. Escoge  un ejemplo para trabajar (recomendamos hacerlo en orden). Cada ejemplo (caso de prueba) comienza con `xspecify`.
2. En ese ejemplo, cambia `xspecify` por `specify` y guarda el archivo. Este cambio hará que esa prueba en particular no se omita en la siguiente ejecución de prueba.
3. La prueba fallará inmediatamente porque no has escrito el código necesario.
4. Escribiras el código necesario y aprobarás la prueba, luego pasa al siguiente ejemplo.

### Automatizar el flujo de trabajo usando Guard

¿Significa esto que debes ejecutar rspec manualmente cada vez que desees trabajar en un ejemplo nuevo? ¡No! Afortunadamente existe cierta automatización que puede ayudarnos. 
[guard](https://rubygems.org/gems/guard/versions/2.18.0) es una joya que detecta cambios en los archivos de tu proyecto y cuando lo hace, vuelve a ejecutar automáticamente un conjunto predefinido de pruebas. 

Hemos configurado guard aquí para que cada vez que cambies el archivo `specfile` o `activerecord_practica.rb`,  vuelvas a ejecutar todas las pruebas que comiencen con `spec` (a diferencia de `xspecify`). 

(Si tiene curiosidad acerca de cómo funciona `Guard`, puede buscar en `Guardfile` para verlo).

- En una ventana de terminal, escribe `guard`. Deberías ver algo como: "Guard is now watching..."
  
Aunque veas un prompt `(guard(main)>)`, no necesitas escribir nada. En una ventana del editor, realiza un cambio trivial en el specfile o en `activerecord_practica.rb`, como insertar un espacio, y guarda el archivo. En uno o dos segundos, la ventana de terminal que ejecuta Guard debería cobrar vida cuando Guard intenta volver a ejecutar las pruebas.

### Como pasar un ejemplo

Trabaja en el primer ejemplo que se enumera en el resultado de `rspec`. ¿Cuál es la salida que debería mostrarse? 

Como sugiere el resultado, echa un vistazo a la linea `xspecify 'alguien con el nombre de Candice'`. En el cuerpo del caso de prueba, puedes ver que la prueba intentará llamar al método de clase `Customer.any_candice`. Cambia `xspecify` por `specify`  guarda el specfile  y Guard debería ejecutar las pruebas una vez más,  pero esta vez, la prueba número 1 no se omitirá sino que fallará.

Ahora ve a `lib/activerecord_practica.rb` donde hemos definido un método vacío `Customer.any_candice`. Completa el cuerpo de este método para que devuelva el enumerable de objetos `Customer` cuyos nombres coincidan con "Candice". (Recordatorio: el archivo `customers.csv` contiene una versión exportada del contenido de `customers.sqlite3`, que es la base de datos utilizada por este código). 
Cada vez que realizas un cambio y guardaa `activerecord_practica.rb`, Guard volverá a ejecutar las pruebas. 

Cuando finalmente consigas llamar correctamente al método, la prueba pasará y el nombre de la prueba se imprimirá en verde, con todas las pruebas aún pendientes impresas en amarillo. Luego puedes pasar al siguiente ejemplo.

Ten en cuenta que para la mayoría de los casos de prueba, el caso de prueba fallará inicialmente porque el método de clase de `Customer `al que intentas llamar no existe en absoluto (solo proporcionamos esqueletos de métodos vacíos para los primeros ejemplos). Pero al leer el código de cada caso de prueba, puedes ver cómo se espera que se nombre el método de clase y definirlo tu mismo.

Cuando todos los ejemplos pasen (RSpec debe imprimir el nombre de cada ejemplo pasado en verde), ¡habrás terminado la actividad!.

NOTA: Si deseas probar los ejemplos de forma interactiva, inicia el intérprete de Ruby con `bundle exec irb` y luego, dentro del intérprete de Ruby, escribe `load 'activerecord_practica.rb'`. 
Esto definirá la clase `Customer` y te permitirá probar cosas como `Customer.where(...)` directamente en el `REPL (read-eval-print loop)`.


### Información adicional 

Aunque ActiveRecord es una parte clave de Rails, puedes usar la biblioteca ActiveRecord fuera de una aplicación Rails. De hecho, estos ejercicios utilizan ActiveRecord, pero los ejercicios en sí no constituyen una aplicación Rails. Entonces, hay algunas diferencias entre cómo usamos AR aquí y cómo lo usarías en una aplicación Rails:

1. El Gemfile enumera `active_record` como una dependencia explícita. En una aplicación Rails, Gemfile simplemente enumeraría Rails como una gema, pero Rails a su vez depende de `active_record` y Bundler detectaría y resolvería esa dependencia.
2. De manera similar, en `activerecord_practica.rb` hay una llamada a `establish_connection`. En una aplicación Rails normal nunca necesitarías esto, ya que Rails se encarga de administrar las conexiones de la base de datos e incluso hay extensiones de Rails que pueden distribuir conexiones entre múltiples bases de datos y manejar la replicación maestro-esclavo.
3. Los dos archivos de la actividad, `activerecord_practica.rb` y  `spec/activerecord_practica_spec.rb`, requieren explícitamente varias gemas. Si se tratara de una aplicación Rails, Rails requeriría automáticamente todas las gemas en su Gemfile cuando se inicie su aplicación, por lo que casi nunca vería requisitos explícitos en los archivos de código.
   
Finalmente, para los curiosos, puede que se pregunten por qué las pruebas RSpec se comportan igual cada vez en los casos en los que se modifica la base de datos. Por ejemplo, si pasas con éxito el caso de prueba  `"eliminar al cliente Meggie Herman"` ¿no causaría eso problemas cuando vuelvas a ejecutar las pruebas y ese cliente ya haya sido eliminado?

Esto se maneja ejecutando cada prueba dentro de una transacción de base de datos y justo antes de que finalice el caso de prueba, generando una `pseudoexcepción` que hará que la transacción se [revierta](https://en.wikipedia.org/wiki/Rollback_(data_management)), lo que provoca que se deshagan todos los cambios visibles dentro de la transacción. 

Cuando probamos aplicaciones Rails, esta es también la forma en que se maneja la base de datos de prueba: cada caso de prueba (y tendrás cientos o miles de ellos) comienza y termina con la base de datos en el mismo estado "limpio", para que se ejecuten. en un entorno predecible.

