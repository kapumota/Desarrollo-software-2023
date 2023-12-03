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

### Análisis de escenarios de Cucumber

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
### Historias de usuarios para escenarios Cucumber

Convierte las siguientes historias de usuarios en escenarios de Cucumber:

- Como usuario de un sitio web de comercio electrónico, para poder agregar todos los artículos que quiero comprar en un solo
  lugar para verlos más tarde, puedo agregar artículos de interés a mi carrito.
- Como usuario de un sitio web de comercio electrónico que califica para la experiencia de pago especial, para poder
  experimentar una experiencia de compra más rápida, simple y contextual, utilizo la experiencia de pago especial cada vez que hago clic en comprar ahora.

   
