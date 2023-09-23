### Introducción a HTTP y URI 

- Utiliza las herramientas de línea de comandos [curl](https://curl.se/) y [nc](https://nmap.org/ncat/) para experimentar y aprender sobre HTTP y las cookies.
- Comprender los conceptos básicos de cómo se construyen las solicitudes y respuestas HTTP y la interacción entre un cliente SaaS y un servidor mediante HTTP.
- Comprender algunos de los códigos de error HTTP más comunes y su significado
- Comprender cómo se gestionan las cookies entre clientes y servidores 

#### Requisitos previos 

Necesitarás saber cómo abrir una terminal o ventana de shell en tu entorno informático , cómo ver y editar archivos. 
A lo largo de esta actividad, nos referiremos a esta ventana como ventana de shell, los comandos que escribe en el prompt  son comandos de shell, es decir, le dicen al 
shell que ejecute un programa y muestre el resultado. 

### Configuración

Usaremos dos herramientas de línea de comandos [CURL](https://www.hostinger.es/tutoriales/comando-curl ) (pronunciado "curl") para actuar como cliente SaaS y
[netcat](https://nmap.org/ncat/))(pronunciado "netcat") para actuar como servidor SaaS. 

También trabajaremos con un sitio web  generador de palabras aleatorias: http://randomword.saasbook.info/.

Comenzamos visitando el generador de palabras aleatorias en tu navegador favorito para obtener una `vista de usuario` de lo que hay en la página principal. 

### Comprendiendo Request y Response 

El uso más básico de curl es emitir un HTTP GET o POST a un sitio, así que intenta:

`curl 'http://randomword.saasbook.info'`

y verifica que lo que ve impreso pueda corresponder de manera plausible al contenido de la página que viste en tu navegador previamente. 
(Las comillas simples no son técnicamente necesarias en este caso, pero deberías acostumbrarte a usarlas con curl, porque los URI a menudo tendrán caracteres 
especiales, como `?` o `#`, que el shell de Unix interpretaría de manera especial si no están protegidos por comillas simples). 

Guarda el contenido del comando `curl` anterior en un archivo y visualiza el archivo como lo representaría un navegador. 

Sugerencia 1: agregar `>nombreArchivo` al final de una línea de comando del shell hace que la salida del comando se almacene en ese archivo en lugar de mostrarse en la ventana del terminal. 

Sugerencia 2: Vista previa del archivo en un navegador:  Si estás guardando archivos en el disco duro de tu propia computadora, almacena el resultado del comando en un archivo con 
una extensión `.html` y abre el archivo creado con tu navegador.  


**Pregunta:**¿Cuáles son las dos diferencias principales que has visto anteriormente  y lo que ves en un navegador web 'normal'? ¿Qué explica estas diferencias? 

Ahora veamos cómo cree el servidor que se ve una solicitud. Para ello, en otra pestaña o ventana de Terminal, nos haremos pasar por un servidor Web escuchando el puerto 8081:  `nc -l 8081`. 

(Como ocurre con la mayoría de los programas de línea de comandos de Unix, puedes decir `nc --help` para obtener una lista de otras opciones, o `man nc` para ver la 'página de manual' detallada). 


**Pregunta:** Suponiendo que estás ejecutando curl desde otro shell  ¿qué URL tendrás que pasarle a curl para intentar acceder a tu servidor falso y por qué? 

Visita tu servidor 'falso' con curl y la URL correcta. Tu servidor 'falso' recibirá la solicitud del cliente HTTP. 

**Pregunta:** La primera línea de la solicitud identifica qué URL desea recuperar el cliente. ¿Por qué no ves `http://localhost:8081` en ninguna parte de esa línea? 

Toma nota de los encabezados que ves: así es como un servidor web real percibe una conexión desde curl. 

Ahora que ha visto cómo se ve una solicitud HTTP desde el punto de vista del servidor, veamos cómo se ve la respuesta desde el punto de vista del cliente. 

En particular, curl simplemente imprime el contenido enviado desde el servidor, pero nos gustaría ver los encabezados del servidor. 

Prueba `curl --help` para ver la ayuda y verificar que la línea de comando `curl -i 'http://randomword.saasbook.info'` mostrará ambos (BOTH) encabezados de respuesta del servidor 
y(AND) luego el cuerpo de la respuesta. 

**Pregunta:** Según los encabezados del servidor, ¿cuál es el código de respuesta HTTP del servidor que indica el estado de la solicitud del cliente y qué versión del protocolo HTTP 
utilizó el servidor para responder al cliente? 

**Pregunta:** Cualquier solicitud web determinada puede devolver una página HTML, una imagen u otros tipos de entidades. 
¿Hay algo en los encabezados que crea que le dice al cliente cómo interpretar el resultado? 
