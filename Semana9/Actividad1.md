## BDD y historias de usuarios

Presenta tus respuestas en un repositorio llamado `BDD`. La actividad es individual.

### BDD

1. ¿Cuál es la diferencia entre validación y verificación? Proporciona un ejemplo de cada uno. ¿Qué intenta abordar BDD?

2. Las historias de usuarios deben ser SMART. DesarrollA un ejemplo de una historia SMART para la página de preguntas
   frecuentes de un sitio web.

3. Describe la relación entre `Features`, `Scenarios` y `Steps` en Cucumber.

4. Cucumber permite que los pasos comiencen con `Given`,`When`, `Then`, `And`, `But`, etc. Aunque son funcionalmente idénticos, ¿cuándo se debe usar cada uno?

5. El formato Connextra se describe anteriormente. Vuelva a escribir la misma historia de usuario SMART que escribistes para la
   pregunta anterior en el formato Connextra.

   ```
    Como [tipo de parte interesada]:
    Para que [pueda lograr algún objetivo]:
    Quiero [hacer alguna tarea]
   ```

6. Nombra tres ventajas de utilizar mockups Lo-Fi.
7. Crea un sketch poco detallado (Lo-Fi) mostrando el comportamiento actual de la aplicación RottenPotatoes.
8. Inventa una funcionalidad que te gustaría añadir a RottenPotatoes y dibuja storyboards que muestren cómo se implementaría y se utilizaría.
9. Convierte las historias de usuario de RottenPotatoes en un documento de especificación de requisitos software. ¿Encuentra alguna dificultad para expresarlo en un SRS?

### Cucumber

1. Crea definiciones de pasos que te permitan escribir los siguientes pasos en un escenario de RottenPotatoes:

   ```
    Given the movie "Inception" exists
   And it has 5 reviews
   And its average review score is 3.5
   ```
2. Escriba una lista de pasos de background que inserten varias películas en RottenPotatoes.
3. Crea una definición de paso en Cucumber que le permita comprobar la existencia de múltiples apariciones de un string en una página, como por ejemplo Entonces debo ver 'Hurra' 3 veces. Sugerencia: Piensa en lo que ocurre si divides el texto de la página
en trozos separados por la cadena de caracteres que debe encontrar.

Las siguientes historias de usuario se convirtieron en escenarios de Cucumber. Nombra tres cosas que podrían mejorarse en 
cada historia de usuario y cómo se relaciona esto con la facilidad de implementación de la prueba de aceptación que 
representa la historia. Hay muchas respuestas correctas. La idea principal es que deberían centrarse en conceptos SMART.

``` 
Escenario: el usuario debe pagar la compra al realizar la compra ahora
  Dado que he iniciado sesión y estoy visitando la página de un producto en mi sitio web de comercio electrónico,
  Cuando compro el producto,
  Entonces debo pagar el producto.
```

```
Escenario: el mal actor no puede editar las listas de tareas pendientes de otros usuarios
  Dado que no he iniciado sesión ni estoy en la página de inicio de la aplicación de tareas pendientes,
  Cuando intento agregar un elemento a la lista de tareas pendientes de otro usuario,
  Entonces debería recibir una severa advertencia.
```

Convierte las siguientes historias de usuarios en escenarios de Cucumber:

- Como usuario de un sitio web de comercio electrónico, para poder agregar todos los artículos que quiero comprar en un solo
  lugar para verlos más tarde, puedo agregar artículos de interés a mi carrito.
- Como usuario de un sitio web de comercio electrónico que califica para la experiencia de pago especial, para poder
  experimentar una experiencia de compra más rápida, simple y contextual, utilizo la experiencia de pago especial cada vez que hago clic en comprar ahora.

### Cucumber y Capybara

Las historias de usuarios son una primitiva central para el BDD y tener un lenguaje de dominio que nos permita implementar y capturar este comportamiento de una manera técnica y procesable es importante para verificar la corrección de nuestra aplicación de acuerdo con las necesidades del cliente. Ahí es donde entran Cucumber y e Capybara.

Cucumber nos permite especificar pasos de escenario altos. Declaraciones como "Dado que he iniciado sesión como 'Chalo'" o 
"Cuando compro el artículo 'Libro de texto'". Es posible que requiera varios pasos para implementarlo con Cucumber. En esta discusión, esperamos familiarizarlo con algunos de los conceptos básicos del uso de esta herramienta. Acostumbrarse a Cucumber y Capybara puede ser complicado, por lo que presentaremos algunas herramientas y prácticas poderosas que puedes utilizar para mejorar la expresividad y el poder de tus propios escenarios de Cucumber.

#### Más sobre Cucumber

Cucumber es una herramienta para ejecutar pruebas automatizadas escritas en lenguaje sencillo. Las ventajas de Cucumber son principalmente 1. Son muy legibles por humanos. 2. El lenguaje es muy expresivo y puede capturar una variedad de escenarios. Hay 3 habilidades de Cucumber que nos interesan especialmente:

1. Escribir pasos y definiciones de pasos: uso de la sintaxis de Cucumber y expresiones regulares

2. Identificar e interactuar con controles de entrada en una página (es decir, formularios, campos, enlaces, botones): uso de CSS (buscar/nombrar elementos), métodos de Capybara (`fill_in`, `click`, `follow`, `select`)

3. Verificar el resultado de la página: usar expectativas (similares a las `aseveraciones`) para verificar los resultados.

Como repaso, a continuación se muestra una implementación de una historia de usuario, escrita en formato Connextra, como un escenario Cucumber. El primer bloque es la historia del usuario, mientras que el segundo bloque es la implementación de Cucumber.

```
Escenario: get free movie ticket on my birthday
   Given I am logged in as "Ire Lara"
   And my birthday is set to "May 12"
```

```
Given /^my birthday is set to "(.⁎")"/ do |date|
   @customer.update_attributes!(:birthday
      => Date.parse(date))
end
```
Ahora, echemos un vistazo a algunas convenciones recomendadas para escribir escenarios de Cucumber.

Los [escenarios de Cuke](https://stackoverflow.com/questions/19812085/how-to-create-a-cuke-step-definition-that-will-test-that-only-certainly-results) se ejecutan en el contexto de un objeto llamado World. Cuando haces referencia a variables de instancia en una definición de paso de Cuke, son variables de instancia de ese objeto, por lo que sobreviven en todos los pasos (pero no en todos los escenarios). Esto te permite transportar el estado a través de los pasos de Cucumber.

Por ejemplo, en un sitio ampliado de RottenPotatoes, un usuario tiene una colección de películas favoritas. El URI de la página de inicio de un usuario que ha iniciado sesión es `/users/:id` (donde `:id` es una clave principal) y el URI para ver la colección favorita de ese usuario es `/users/:id/favorites`.

¿Cómo usarías variables de instancia en los pasos de Cuke para crear las siguientes definiciones de pasos?

```
Given I am logged in as user "An Ju"
And my favorite collection contains the item "The Bourne Identity"
```
Escribe su implementación de Cucumber a continuación.

### Capybara

Además de `contain`, que analiza el texto del elemento, Capybara proporciona una gran cantidad de `matchers` para examinar una página. Por ejemplo, si solo deseas verificar la presencia de un elemento de página (por ejemplo, un mensaje de error), puede escribir:

```
expect(page).to have_selector("p.error", :text => 'Ocurre un error')
```

Nota: El método real definido en Capybara es `has_selector?`, porque RSpec es lo suficientemente inteligente como para interpretar `have_selector` como una llamada a `has_selector?`.

`page` es un método `Capybara` que devuelve una representación del objeto de la página y `page.body` es una cadena que contiene el HTML sin formato del texto completo de la página.

   
