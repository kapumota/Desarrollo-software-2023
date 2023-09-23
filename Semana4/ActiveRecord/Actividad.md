### Conceptos básicos de ActiveRecord

Para esta actividad, hemos creado una base de datos de 30 clientes falsos, con nombres falsos, direcciones de correo electrónico falsas y fechas de nacimiento falsas 
(cortesía de [Faker gem](https://github.com/faker-ruby/faker)) y escribirás varias consultas de ActiveRecord para extraer y/o actualizar subconjuntos de estos clientes.

Como beneficio adicional, obtendrás más experiencia utilizando las **pruebas continuas**, en las que cada vez que realiza un cambio en el código o las 
pruebas, se vuelve a ejecutar automáticamente un conjunto completo de pruebas automatizadas. De esta manera, puedes entrar en un "ritmo" de codificación y pruebas sin volver a 
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

Sin embargo, no ejecutes este archivo directamente. En su lugar, utilizarás el archivo de especificación, que contiene una prueba para cada una de las consultas que debe escribir.

- Ejecuta el archivo de prueba una vez con `bundle exec rspec spec/activerecord_practice_spec.rb`. (Recuerda que `bundle exec` es necesario para garantizar que las versiones
  correctas de las gemas requeridas se carguen y activen correctamente antes de ejecutar el código). El resultado debe ser `13 ejemplos, 0 fallas, 13 pendientes`.

Hemos configurado las pruebas para que inicialmente se omitan todas las pruebas. (Todos fallarían porque aún no has escrito el código para ellos). 
Abre el archivo de especificaciones y echa un vistazo. Su flujo de trabajo será el siguiente:
Elige un ejemplo para trabajar (recomendamos hacerlo en orden). Cada ejemplo (caso de prueba) comienza con xspecify.
En ese ejemplo, cambie xspecify para especificar y guardar el archivo; Este cambio hará que esa prueba en particular no se omita en la siguiente ejecución de prueba.
La prueba fallará inmediatamente porque no has escrito el código necesario.
Escribirá el código necesario y aprobará la prueba; luego pase al siguiente ejemplo.


### Automatizar el flujo de trabajo usando Guard
¿Significa esto que debe ejecutar rspec manualmente cada vez que desee trabajar en un ejemplo nuevo? ¡No! Afortunadamente existe cierta automatización que puede ayudarnos. guard es una joya que detecta cambios en los archivos de su proyecto y, cuando lo hacen, vuelve a ejecutar automáticamente un conjunto predefinido de pruebas. Hemos configurado guard aquí para que cada vez que cambie el archivo specfile o activerecord_practice.rb, 
vuelva a ejecutar todas las pruebas que comiencen con spec (a diferencia de xspecify). (Si tiene curiosidad acerca de cómo funciona Guard, puede buscar en Guardfile para verlo, pero no necesita preocuparse por eso).
En una ventana de terminal, escriba guard. Deberías ver algo como
"La guardia ahora está mirando..."
Aunque vea un mensaje (guardia(principal)>), no necesita escribir nada. En una ventana del editor, realice un cambio trivial en el archivo de especificaciones o en activerecord_practice.rb, como insertar un espacio, y guarde el archivo. En uno o dos segundos, la ventana de terminal que ejecuta Guard debería cobrar vida cuando Guard intenta volver a ejecutar las pruebas.
Consigue que pase tu primer ejemplo
Trabajemos en el ejemplo n.° 1 que se enumera en el resultado de rspec. La salida debería verse así:

Como sugiere el resultado, eche un vistazo a la línea 40 en el archivo de especificaciones. En el cuerpo del caso de prueba, puede ver que la prueba intentará llamar al método de clase Customer.any_candice. Cambie xspecify para especificar en la línea 40, guarde el archivo de especificaciones y Guard debería ejecutar las pruebas una vez más; pero esta vez, la prueba número 1 no se omitirá sino que fallará.
Ahora vaya a lib/activerecord_practice.rb donde hemos definido un método vacío Customer.any_candice. Complete el cuerpo de este método para que devuelva el enumerable de objetos Cliente cuyos nombres coincidan con "Candice".
(Recordatorio: el archivo clientes.csv contiene una versión exportada del contenido de clientes.sqlite3, que es la base de datos utilizada por este código). Cada vez que realiza un cambio y guarda activerecord_practice.rb, Guard volverá a ejecutar las pruebas. Cuando finalmente consigas llamar correctamente al método, la prueba pasará y el nombre de la prueba se imprimirá en verde, con todas las pruebas aún pendientes impresas en amarillo. Luego puedes pasar al siguiente ejemplo.
Tenga en cuenta que para la mayoría de los casos de prueba, el caso de prueba fallará inicialmente porque el método de clase de Cliente al que intenta llamar no existe en absoluto (solo proporcionamos esqueletos de métodos vacíos para los primeros ejemplos). Pero al leer el código de cada caso de prueba, puede ver cómo se espera que se nombre el método de clase y definirlo usted mismo.
Cuando todos los ejemplos pasen (RSpec debe imprimir el nombre de cada ejemplo pasado en verde), ¡ya estará listo!
NOTA: Si desea probar los ejemplos de forma interactiva, inicie el intérprete de Ruby con el paquete exec irb y luego, dentro del intérprete de Ruby, escriba cargar 'activerecord_practice.rb'. Esto definirá la clase Cliente y le permitirá probar cosas como Customer.where(...) directamente en el REPL (bucle de lectura-evaluación-impresión).
Consejos y enlaces útiles
Como de costumbre, tendrás que buscar la documentación de ActiveRecord para saber cómo hacer que funcionen estas consultas, lo cual es parte del proceso de aprendizaje:


Introducción a ActiveRecord
Consultas básicas usando ActiveRecord
Documentación completa de ActiveRecord (para Rails 4.2.x)
Aunque los ejemplos requieren filtrar y, a veces, ordenar un subconjunto de registros de clientes, nunca debería necesitar llamar a métodos de recopilación de Ruby como map, recopilar u ordenar: el 100% del trabajo se puede realizar en la llamada ActiveRecord.
Además, el objetivo es pasar cada prueba utilizando la interfaz de consulta de ActiveRecord, no llamando a find() con los identificadores de los registros de resultados esperados. Para eliminar esa tentación, las pruebas RSpec generan un error si usa directamente ActiveRecord::Base.find en su código. (Más adelante en el curso exploraremos los mecanismos RSpec que nos permiten realizar este "seguimiento de métodos" para deshabilitar ciertos métodos en las pruebas).
Finalmente, si está interesado en aprender más sobre los comandos SQL (lenguaje de consulta estructurado) subyacentes que genera ActiveRecord, le recomendamos:
Consultas SQL, otro curso breve a su propio ritmo de nuestros amigos de Stanford
Enseñanza SQL, que le permite de forma interactiva
Información adicional adicional
Aunque ActiveRecord es una parte clave de Rails, puedes usar la biblioteca ActiveRecord fuera de una aplicación Rails. De hecho, estos ejercicios utilizan ActiveRecord, pero los ejercicios en sí no constituyen una aplicación Rails. Entonces, hay algunas diferencias entre cómo usamos AR aquí y cómo lo usarías en una aplicación Rails:
El Gemfile enumera active_record como una dependencia explícita. En una aplicación Rails, Gemfile simplemente enumeraría Rails como una gema, pero Rails a su vez depende de active_record, y Bundler detectaría y resolvería esa dependencia.
De manera similar, en activerecord_practice.rb hay una llamada para establecer_conexión. En una aplicación Rails normal nunca necesitarías esto, ya que Rails se encarga de administrar las conexiones de la base de datos e incluso hay extensiones de Rails que pueden distribuir conexiones entre múltiples bases de datos y manejar la replicación maestro-esclavo.
Los dos archivos de la tarea, activerecord_practice.rb y el archivo de especificaciones spec/activerecord_practice_spec.rb, requieren explícitamente varias gemas. Si se tratara de una aplicación Rails, Rails requeriría automáticamente todas las gemas en su Gemfile cuando se inicie su aplicación, por lo que casi nunca vería requisitos explícitos en los archivos de código.
Finalmente, para los curiosos, puede que se pregunten por qué las pruebas RSpec se comportan igual cada vez en los casos en los que se modifica la base de datos. Por ejemplo, si pasa con éxito el caso de prueba n.º 12, "eliminar al cliente Meggie Herman", ¿no causaría eso problemas cuando vuelva a ejecutar las pruebas y ese cliente ya haya sido eliminado?
Esto se maneja ejecutando cada prueba dentro de una transacción de base de datos y, justo antes de que finalice el caso de prueba, generando una pseudoexcepción que hará que la transacción se revierta, lo que provoca que se deshagan todos los cambios visibles dentro de la transacción. Cuando probamos aplicaciones Rails, esta es también la forma en que se maneja la base de datos de prueba: cada caso de prueba (y tendrá cientos o miles de ellos) comienza y termina con la base de datos en el mismo estado "limpio", para que se ejecuten. en un entorno predecible.
