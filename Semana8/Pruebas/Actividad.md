## Todo sobre pruebas

Siempre que hablamos de pruebas pragmáticas, una de las primeras decisiones que debemos tomar es el nivel en el que probar el código. Por nivel de prueba, mencionamos al nivel de unidad, integración o sistema.  

Presenta todas tus respuestas en un repositorio llamado Pruebas.

#### Pruebas unitarias

Esta es una definición de prueba unitaria dada por Roy Osherove (2009): "Una prueba unitaria es una pieza de código automatizada que invoca una unidad de trabajo en el sistema. Y una unidad de trabajo puede abarcar un solo método, una clase completa o varias clases que trabajan juntas para lograr un solo propósito lógico que se puede verificar". 

Pero, ¿qué pasa si una clase que quiero probar depende de otra clase que se comunica, por ejemplo, con una base de datos (figura )? 


![](https://github.com/kapumota/Desarrollo-software-2023/blob/main/Semana8/Pruebas/Imagenes/Prueba.png).


Cuando realizamos pruebas unitarias de clase A, el enfoque está en probar A ¡lo más aislado posible del resto!. Si A depende de otras clases, tenemos que decidir en usar mocks, stubs o hacer que nuestra prueba unitaria sea un poco más grande.

Aquí es donde las pruebas unitarias se vuelven más complicadas. 

Aquí hay una respuesta corta: si quieres probar una clase, y esta clase depende de otra clase que depende de una base de datos, simula la clase de la base de datos. 
En otras palabras, crea un **stub**  que actúe como la clase original pero que sea mucho más simple y fácil de usar durante las pruebas.

#### Pruebas de integración 

Las pruebas unitarias se centran en las partes más pequeñas del sistema. Sin embargo, probar los componentes de forma aislada a veces no es suficiente. 
Esto es especialmente cierto cuando el código bajo prueba va más allá de los límites del sistema y utiliza otros componentes (a menudo externos). 

La prueba de integración es el nivel de prueba que usamos para probar la integración entre el código y partes externas. 

**Ejemplo** 

Los sistemas de software comúnmente se basan en sistemas de bases de datos. Para comunicarse con la base de datos, los desarrolladores a menudo crean una clase cuya única responsabilidad es interactuar con este componente externo (piensa en las clases de objetos de acceso a datos [DAO]). Estos DAO pueden contener código SQL complicado. 

Por lo tanto  un evaluador siente la necesidad de probar las consultas SQL. El evaluador no quiere probar todo el sistema, solo la integración entre la clase DAO y la base de datos. 
El evaluador tampoco quiere probar la clase DAO en completo aislamiento. Después de todo, la mejor manera de saber si una consulta SQL funciona es enviarla a la base de datos y ver qué devuelve la base de datos. Este es un ejemplo de una prueba de integración. 

Las pruebas de integración tienen como objetivo probar múltiples componentes de un sistema juntos, centrándose en las interacciones entre ellos en lugar de probar el sistema como un todo. ¿Se están comunicando correctamente? ¿Qué sucede si el componente A envía un mensaje X al componente B? ¿Siguen presentando un comportamiento correcto?

Las pruebas de integración se centran en dos partes: el componente a analizar y el componente externo. Escribir una prueba de este tipo es menos complicado que escribir una prueba que atraviese todo el sistema e incluya componentes que no nos interesan. 

En comparación con las pruebas unitarias, las pruebas de integración son más difíciles de escribir. 

#### Pruebas del sistema 

Para obtener una vista más realista del software y, por lo tanto, realizar pruebas más realistas, debemos ejecutar todo el sistema de software con todas sus bases de datos, aplicaciones de interfaz y otros componentes.
Cuando probamos el sistema en su totalidad, en lugar de probar pequeñas partes del sistema de forma aislada, estamos haciendo pruebas del sistema . 
No nos importa cómo funciona el sistema desde adentro, no nos importa si fue desarrollado en Java o Ruby, o si utiliza una base de datos relacional. 

Solo nos importa que, dada la entrada X, el sistema proporcione la salida Y. 

Al probar el sistema, deseas ejercitar todo el sistema en conjunto, incluidas todas sus clases, dependencias, bases de datos, servicios web y cualquier otro componente que pueda tener.

La ventaja obvia de las pruebas del sistema es cuán realistas son las pruebas. Nuestros clientes finales no ejecutarán el método identifyExtremes() de forma aislada. Más bien, visitarán una página web, enviarán un formulario y verán los resultados. Las pruebas del sistema ejercitan el sistema de esa manera precisa. Cuanto más realistas sean las pruebas (es decir, cuando las pruebas realicen acciones similares a las del usuario final), más confianza podremos tener sobre todo el sistema. 

Sin embargo, las pruebas del sistema tienen sus desventajas: 

- Las pruebas del sistema suelen ser lentas en comparación con las pruebas unitarias. 
- Las pruebas del sistema también son más difíciles de escribir. 
- Las pruebas del sistema son más propensas a ser inestables. Una prueba inestable presenta un comportamiento errático: si la ejecutas, puede pasar o fallar para la misma configuración. Las pruebas inestables son un problema importante para los equipos de desarrollo de software.

#### Cuándo usar cada nivel de prueba 

Con una comprensión clara de los diferentes niveles de prueba y sus beneficios, tenemos que decidir si invertir más en pruebas unitarias o pruebas del sistema y determinar qué componentes deben probarse mediante pruebas unitarias y qué componentes deben probarse mediante pruebas del sistema. Una decisión equivocada puede tener un impacto considerable en la calidad del sistema: un nivel incorrecto puede costar demasiados recursos y no encontrar suficientes errores. Como habrás adivinado, la mejor respuesta aquí es: "Depende". 

A menudo se usa una pirámide para ilustrar esta idea, como se muestra en la figura:


<img src="https://github.com/kapumota/Desarrollo-software-2023/blob/main/Semana8/Pruebas/Imagenes/TrianguloPruebas.png" alt="drawing" width="500"/>

El tamaño de una parte en la pirámide representa el número relativo de pruebas a realizar en cada nivel de prueba. 

**Ejercicios**

Responde las siguientes preguntas:

1. ¿Qué nivel de prueba suele realizar el personal de administración de un sistema?

2. Considera este requisito: "Una tienda web ejecuta un trabajo por lotes, una vez al día, para entregar todos los pedidos que se han pagado. También establece la fecha de entrega según si el pedido es de un cliente internacional. Los pedidos se recuperan de una base de datos externa. Los pedidos que se han pagado se envían a un servicio web externo”. Como evaluador, debes decidir qué nivel de prueba (unidad, integración o sistema) aplicar.  ¿Qué tipo de prueba aplicarias a este caso?

3. Inspectora Motita acaba de comenzar una consultoría para una empresa que desarrolla una aplicación móvil para ayudar a las personas a mantenerse al día con sus ejercicios diarios. Los miembros del equipo de desarrollo son fanáticos de las pruebas de software automatizadas y más específicamente, de las pruebas unitarias. Tienen una alta cobertura de código de prueba de unidad  pero los usuarios aún informan una cantidad significativa de errores. Motita, que está bien versada en pruebas de software, explica un principio de prueba al equipo. ¿De cuál principio habló?.

4. Monky  un tester de software junior, acaba de unirse a una empresa de pago en línea muy grande en Escocia. Como primera tarea, Monky analiza los informes de errores de los últimos dos años. Él observa que más del 50% de los errores ocurren en el módulo de pagos internacionales. El le promete a su gerente que diseñará casos de prueba que cubran completamente el módulo de pagos internacionales y así encontrar todos los errores. ¿Pueden las pruebas exhaustivas pueden explicar por qué esto no es posible?

5. ¿Cuál es la razón principal por la que el número de pruebas recomendadas del sistema en la pirámide de pruebas es menor que el número de pruebas unitarias?

6. Una universidad (X) ha creado un software interno para gestionar la nómina de los empleados. La aplicación utiliza tecnologías web  de Java y almacena datos en una base de datos de Postgres. La aplicación recupera, modifica e inserta con frecuencia grandes cantidades de datos. Toda esta comunicación se realiza mediante clases Java que envían consultas SQL (complejas) a la base de datos. Como evaluadores sabemos que un error puede estar en cualquier lugar, incluso en las consultas SQL. También sabemos que hay muchas formas de ejercitar nuestro sistema. ¿Cuál  es una buena opción para detectar errores en consultas SQL?

7. Chalito, un evaluador de software con mucha experiencia, visita FCX!, una red social enfocada en emparejar personas según los cursos que llevan. Los usuarios no informan errores a menudo, ya que  los desarrolladores cuentan con sólidas prácticas de prueba. Sin embargo, los usuarios dicen que el software no cumple lo que promete. ¿Qué principio de prueba se aplica aquí?

8. Kapumota cree firmemente en las pruebas unitarias. De hecho, este es el único tipo de prueba que realiza para cualquier proyecto del que forma parte. ¿Qué principio de prueba no ayudará a convencer a Kapumota de que debe alejarse de su enfoque de "pruebas unitarias únicas"?

9. TDD se ha convertido en una práctica popular entre los desarrolladores. Según ellos, el TDD tiene varios beneficios. Indica algunos ejemplos no se considera un beneficio el TDD.

10. Indica algunas recomendaciones a seguir para mantener una aplicación web comprobable.


### Comentarios

Mucha gente no está de acuerdo con la idea de una pirámide de pruebas y si deberíamos favorecer las pruebas unitarias. Estos desarrolladores abogan por un nivel inferior más delgado con pruebas unitarias, una porción intermedia más grande con pruebas de integración y una parte superior más delgada con pruebas de sistema. 

Claramente, estos desarrolladores ven el mayor valor en escribir pruebas de integración. 

En muchos sistemas de software, la mayor parte de la complejidad está en la integración de componentes. Por ejemplo en una arquitectura de microservicios altamente distribuida el desarrollador puede sentirse más cómodo si las pruebas automatizadas realizan llamadas reales a otros microservicios en lugar de confiar en stubs o mocks que los simulan. ¿Por qué escribir pruebas unitarias para algo que tiene que probar de todos modos a través de pruebas de integración?.

Otro caso común a favor de las pruebas de integración en lugar de las pruebas unitarias involucra los sistemas de información centrados en bases de datos: es decir, sistemas donde la responsabilidad principal es almacenar, recuperar y mostrar información. En tales sistemas, la complejidad se basa en garantizar que el flujo de información viaje con éxito a través de la interfaz de usuario a la base de datos y viceversa. 

Tales aplicaciones a menudo no están compuestas por algoritmos complejos o reglas comerciales. En ese caso, las pruebas de integración para garantizar que las consultas SQL (que a menudo son complejas) funcionen como se espera y las pruebas del sistema para garantizar que la aplicación en general se comporte como se espera pueden ser el camino a seguir.

Preferir un enfoque sobre otro es en gran medida una cuestión de gusto personal, experiencia y contexto. Debes realizar el tipo de prueba que crees que beneficiará a tu software. Todos los enfoques tienen pros y contras, y tendrás que encontrar el que funcione mejor para ti y tu equipo de desarrollo. 


En [Software Engineering at Google](https://abseil.io/resources/swe-book)  (Winters, Manshreck y Wright, 2020), los autores mencionan que Google suele optar por pruebas unitarias, ya que tienden a ser más económicas y se ejecutan con mayor rapidez. También se realizan pruebas de integración y del sistema, pero en menor medida. Según los autores, alrededor del 80% de sus pruebas son pruebas unitarias. 

Google también tiene una definición interesante de tamaños de prueba, que los ingenieros consideran al diseñar casos de prueba. 

Una **prueba pequeña** es una prueba que se puede ejecutar en un solo proceso. Tales pruebas no tienen acceso a las principales fuentes de lentitud o determinismo de prueba. En otras palabras, son rápidas y no inestables. 

Una **prueba mediana** puede abarcar varios procesos, usar subprocesos y realizar llamadas externas (como llamadas de red) al localhost. Las pruebas medianas tienden a ser más lentas e inestables que las pequeñas. 

Finalmente, las **pruebas grandes** eliminan la restricción localhost y, por lo tanto, pueden requerir y realizar llamadas a varias máquinas. Google reserva pruebas grandes para pruebas completas de extremo a extremo. 

La idea de clasificar las pruebas no en términos de sus límites (unidad, integración, sistema) sino en términos de qué tan rápido se ejecutan también es popular entre muchos desarrolladores. Una vez más, lo que importa es que, para cada parte del sistema, tu objetivo sea maximizar la eficacia de la prueba. 

La idea es que tu prueba sea lo más económica posible de escribir, lo más rápida posible de ejecutar y que te brinde la mayor cantidad de comentarios posible sobre la calidad del sistema. 


