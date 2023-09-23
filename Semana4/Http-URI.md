## Introducción a HTTP y URI 

- Utiliza las herramientas de línea de comandos [curl](https://curl.se/) y [nc](https://nmap.org/ncat/) para experimentar y aprender sobre HTTP y las cookies.
- Comprender los conceptos básicos de cómo se construyen las solicitudes y respuestas HTTP y la interacción entre un cliente SaaS y un servidor mediante HTTP.
- Comprender algunos de los códigos de error HTTP más comunes y su significado.
- Comprender cómo se gestionan las cookies entre clientes y servidores.

#### Requisitos previos 

Necesitarás saber cómo abrir una terminal o ventana de shell en tu entorno informático , cómo ver y editar archivos. 
A lo largo de esta actividad, nos referiremos a esta ventana como ventana de shell, los comandos que escribe en el prompt  son comandos de shell, es decir, le dicen al 
shell que ejecute un programa y muestre el resultado. 

### Configuración

Usaremos dos herramientas de línea de comandos [curl](https://www.hostinger.es/tutoriales/comando-curl ) para actuar como cliente SaaS y [netcat](https://nmap.org/ncat/) para actuar como servidor SaaS. 

También trabajaremos con un sitio web  generador de palabras aleatorias: http://randomword.saasbook.info/.

Comenzamos visitando el generador de palabras aleatorias en tu navegador favorito para obtener una `vista de usuario` de lo que hay en la página principal. 

### Comprendiendo Request y Response 

El uso más básico de curl es emitir un HTTP GET o POST a un sitio, así que intenta:

`curl 'http://randomword.saasbook.info'`

y verifica que lo que ve impreso pueda corresponder de manera plausible al contenido de la página que viste en tu navegador previamente. 
(Las comillas simples no son técnicamente necesarias en este caso, pero deberías acostumbrarte a usarlas con curl, porque los URI a menudo tendrán caracteres 
especiales, como `?` o `#`, que el shell de Unix interpretaría de manera especial si no están protegidos por comillas simples). 

Guarda el contenido del comando `curl` anterior en un archivo y visualiza el archivo como lo representaría un navegador. 

**Sugerencia 1:** agregar `>nombreArchivo` al final de una línea de comando del shell hace que la salida del comando se almacene en ese archivo en lugar de mostrarse en la ventana del terminal. 

**Sugerencia 2:** Vista previa del archivo en un navegador:  Si estás guardando archivos en el disco duro de tu propia computadora, almacena el resultado del comando en un archivo con 
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
¿Hay algo en los encabezados que crea que le dice al cliente cómo interpretar el resultado?.

### ¿Qué sucede cuando falla un HTTP request? 


**Pregunta:** ¿Cuál sería el código de respuesta del servidor si intentaras buscar una URL inexistente en el sitio generador de palabras aleatorias? Pruéba esto utilizando el procedimiento anterior. 

¿Qué otros códigos de error HTTP existen? Utiliza Wikipedia u otro recurso para conocer los significados de algunos de los más comunes: `200`, `301`, `302`, `400`, `404`, `500`. Ten en cuenta que estas son `familias` de estados: todos los estados 2xx significan `funcionó`, todos los 3xx son `redireccionar` etc. 

Tanto el encabezado `4xx` como el `5xx` indican condiciones de error. ¿Cuál es la principal diferencia entre `4xx` y `5xx`?. 

### ¿Qué es un cuerpo de Request? 

A continuación, crearemos un formulario HTML simple que puedes publicar desde tu navegador e interceptarlo con Netcat como se indicó anteriormente, para que puedas ver cómo se ve un formulario publicado en un servidor web. Esto es relevante porque en tus propias aplicaciones SaaS tendrás que trabajar con los datos del formulario enviado.  

Si bien la mayoría de los frameworks como [Sinatra](https://sinatrarb.com/) y [Rails](https://rubyonrails.org/) hacen un buen trabajo al analizar y predigerir dichos datos de formulario para que estén convenientemente disponibles para tu aplicación, vale la pena comprender cómo se ven normalmente esos datos antes de dicho procesamiento. 

Una vez más, inicia `nc -l 8081` para escuchar en el puerto `8081`. 

Crea y guarda (idealmente con extensión .html) el siguiente archivo:

```
 <!DOCTYPE html>
  <html>
  <head>
    </head>
    <body> <form method="post" action="Url-servidor-falso">
      <label>Email:</label>
       <input type="text" name="email">
        <label>Password:</label>
        <input type="password" name="password">
        <input type="hidden" name="secret_info" value="secret_value">
        <input type="submit" name="login" value="Log In!">
      </form>
    </body>
  </html> 
```

**Pregunta:** Cuando se envía un formulario HTML, se genera una solicitud HTTP `POST` desde el navegador. Para llegar a tu servidor falso, 
¿con qué URL deberías reemplazar `Url-servidor-falso` en el archivo anterior? 

Modifica el archivo, ábrelo en el navegador web de tu computadora, completa algunos valores en el formulario y envíalo. Ahora ve a tu terminal y mira la ventana donde `nc` está escuchando. 

**Pregunta:**¿Cómo se presenta al servidor la información que ingresó en el formulario? ¿Qué tareas necesitaría realizar un framework SaaS como Sinatra o Rails para presentar esta información en un formato conveniente a una aplicación SaaS escrita, por ejemplo, en Ruby? 

Repite el experimento varias veces para responder las siguientes preguntas observando las diferencias en el resultado impreso por `nc`: 

- ¿Cuál es el efecto de agregar parámetros `URI` adicionales como parte de la ruta `POST`?
- ¿Cuál es el efecto de cambiar las propiedades de nombre de los campos del formulario?
- ¿Puedes tener más de un botón `Submit`? Si es así, ¿cómo sabe el servidor en cuál se hizo clic? (Sugerencia: experimenta con los atributos de la etiqueta `<submit>`).
- ¿Se puede enviar el formulario mediante `GET` en lugar de `POST`? En caso afirmativo, ¿cuál es la diferencia en cómo el servidor ve esas solicitudes?
- ¿Qué otros verbos `HTTP` son posibles en la ruta de envío del formulario? ¿Puedes hacer que el navegador web genere una ruta que utilice `PUT`, `PATCH` o `DELETE`?. 

 
### HTTP sin estados y cookies  


En esta sección utilizaremos una aplicación sencilla desarrollada para este curso para ayudarte a experimentar con las cookies. Puedes ver el [código fuente de la aplicación](https://github.com/saasbook/simple-cookie-demo) (utiliza el sencillo framework Sinatra). 

Esta aplicación sólo admite dos rutas: 

- `GET /` devuelve una cadena de texto que indica si el usuario ha iniciado sesión o no. 
- GET /login devuelve una respuesta que indica al navegador que establezca una cookie. La aplicación configura el contenido de las cookies para indicar que el usuario ha iniciado sesión. (En una aplicación real, el servidor ejecutaría algún código que verifica un par de nombre de usuario/contraseña o similar). 

Esta aplicación se encuentra en `http://esaas-cookie-demo.herokuapp.com` pero solo muestra cadenas de texto, no páginas HTML. 

**Pregunta:** Prueba las dos primeras operaciones `GET` anteriores. El cuerpo de la respuesta para la primera debe ser `"Logged in: false"` y para la segunda `"Login cookie set"`. 
¿Cuáles son las diferencias en los encabezados de respuesta que indican que la segunda operación está configurando una cookie? (Sugerencia: usa `curl -v`, que mostrará tanto los encabezados de solicitud como los encabezados y el cuerpo de la respuesta, junto con otra información de depuración. `curl --help` imprimirá una ayuda voluminosa para usar `cURL` y `man curl` mostrará la página del manual de Unix  para cURL en la mayoría de los sistemas.) 

**Pregunta:** Bien, ahora supuestamente `"logged in"` porque el servidor configuró una cookie que indica esto. Sin embargo, si intentaa `GET /` nuevamente, seguirá diciendo `"Logged: false"`. 
¿Qué está sucediendo? (Sugerencia: `usa curl -v` y observa los encabezados de solicitud del cliente). 

Para solucionar este problema, tenemos que decirle a curl que almacene las cookies relevantes que envía el servidor, para que sepa incluirlas en futuras solicitudes a ese servidor. 

Prueba `curl -i --cookie-jar cookies.txt http://esaas-cookie-demo.herokuapp.com/login` y verifica que el archivo `cookies.txt` recién creado contenga información sobre la cookie que coincida con el encabezado `Set-Cookie` de el servidor. Este archivo es cómo curl almacena la información de las cookies. Los navegadores pueden hacerlo de manera diferente. 

Ahora debemos decirle a curl que incluya las cookies apropiadas de este archivo cuando visite el sitio, lo cual hacemos con la opción `-b`: 

`curl -v -b cookies.txt http://esaas-cookie-demo.herokuapp.com/` 

Verifica que la cookie ahora se transmita (pista: mira los encabezados de solicitud del cliente) y que el servidor ahora crea que ha iniciado sesión. 

**Pregunta:** Al observar el encabezado `Set-Cookie` o el contenido del archivo `cookies.txt`, parece que podría haber creado fácilmente esta cookie y simplemente obligar al servidor a creer que ha iniciado sesión. En la práctica, ¿cómo evitan los servidores esta inseguridad? 

Para resumir: la única forma en que el servidor puede "realizar un seguimiento" del mismo cliente es configurando una cookie cuando el cliente visita por primera vez, confiando en que el cliente incluya esa cookie en los encabezados en visitas posteriores y si el servidor modifica la cookie. durante la sesión (al incluir encabezados `Set-Cookie` adicionales), confiando en que el cliente también recuerde esos cambios. 

De esta manera, aunque HTTP en sí no tiene estado (cada solicitud es independiente de las demás), la aplicación puede mantener internamente la noción de "estado de sesión" para cada cliente, utilizando la cookie como un "identificador" para nombrar ese estado internamente. (En la práctica, la mayoría de las aplicaciones SaaS utilizan la cookie para conservar una clave de búsqueda que asigna el valor de la cookie a una estructura de datos más grande y compleja almacenada en el servidor). 

Deshabilitar las cookies en el cliente frustra todos estos comportamientos, razón por la cual la mayoría de los sitios que requieren iniciar sesión  o que te guían a través de una secuencia de páginas para hacer una operación no funcionan correctamente si las cookies están deshabilitadas en el navegador. 
