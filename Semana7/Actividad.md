## Logging y depuración

Realizar depuración en una aplicación de votación. 

Revisa el repositorio :https://github.com/kapumota/Desarrollo-software-2023/tree/main/Semana6/Logging-debugging.

En esta actividad, refactorizaremos una aplicación de máquina de votación para generar un logging que podamos usar con fines de depuración. 

La aplicación de la máquina de votación ha reportado votos y categorías duplicados de nuestros usuarios. 
Lo que nos gustaría hacer es tener un logging histórico de cuándo suceden cosas almacenado en algún lugar al que podamos acceder sin necesidad de ver el resultado de la pantalla. Lo que necesitamos es un archivo log. 

Los siguientes pasos te ayudarán a completar la actividad: 

1. Primero, escribamos una prueba simple para asegurarnos de que la clase Controller realmente tenga acceso a la clase Logger instanciada definida en el inicializador LoggerController. Edita en `tests/test_controller.rb`.

2. A continuación, ampliemos el módulo `ControllerLogger`. Primero necesitaremos agregar un inicializador para que la clase `Controller` padre pueda crear una instancia de la clase `Logger`. Llamaremos a `super` al final del método, que llamará al `initialize` en la clase padre pasando por los mismos parámetros (que es el valor predeterminado cuando se llama a super sin parámetros). Edita en `controller_logger.rb`.

3. Ahora definamos el método `log_to_file` en `ControllerLogger`. Esto es lo que usaremos para escribir en el sistema de archivos mediante la clase `Logger`. Querremos tener la capacidad de sobreescribir el nivel log. Podemos usar el método `send` para evaluar la cadena de nivel en un nombre de método.  Edita en `controller_logger.rb`.

4. Agrega una llamada a `log_to_file` en el método log existente para que capturemos una copia con marca de tiempo del mensaje en el archivo log. Edita en `controller_logger.rb`.
5. Para realizar algunos loggings adicionales, cerremos la sesión de los votos realizados por los usuarios, incluida información adicional. Etiquetaremos este como un log INFO, para que podamos filtrarlo de los logs si es necesario. Edita en `controllers/vote_controller.rb`.
6. Ejecuta el programa y crea categorías, realice votaciones, etc. Inspecciona el archivo `log.txt`. 

