## Testing Java Script y Ajax

Presenta esta actividad en un repositorio llamado `Pruebas-JS-Ajax`. La actividad es individual y se utiliza el repositorio anterior de actividades de ajax.

Para empezar a utilizar [Jasmine](https://jasmine.github.io/), añada `gem jasmine` a tu Gemfile y ejecute bundle como siempre; después, ejecuta los comandos siguientes desde el directorio raíz de tu aplicación.

```
rails generate jasmine_rails:install 
mkdir spec/javascripts/fixtures 
git add spec/javascripts
```

Puedes también revisar y utilizar https://jasmine.github.io/setup/ruby.html 

No podemos ejecutar un conjunto de pruebas Jasmine completamente vacío, así que crea el fichero `spec/javascripts/basic_check_spec.js` con el siguiente código: 

```
describe ('Jasmine basic check', function() { 
    it('works', function() { expect(true).toBe(true); }); 
}); 
```
Para ejecutar pruebas de Jasmine, simplemente inicia tu aplicación con el comando `rails server` y, una vez que se esté ejecutando, busca el subdirectorio `spec` de tu aplicación (por ejemplo, `http://localhost:3000/specs` si desarrollas la actividad en tu propia computadora) para ejecutar todas las especificaciones y ver los resultados. 

**Importante:** De ahora en adelante, cuando cambies cualquier código en `app/assets/javascripts` o pruebas en `spec/javascripts`, simplemente vuelve a cargar la página del navegador para volver a ejecutar todas las pruebas. 

**Pregunta:** ¿Cuáles son los problemas que se tiene cuando se debe probar Ajax?. Explica tu respuesta.

**Pregunta:** ¿Qué son los stubs, espias y fixture en Jasmine para realizar pruebas de Ajax?

La estructura básica de los casos de prueba de Jasmine se hace evidente en el código siguiente como en RSpec, Jasmine utiliza `it` para especificar un único ejemplo y bloques describe anidados para agrupar conjuntos de ejemplos relacionados. Tal y como ocurre en RSpec, `describe` e `it` reciben un bloque de código como argumento, pero mientras que en Ruby los bloques de código están delimitados por `do. . . end`, en JavaScript son funciones anónimas (funciones sin nombre) sin argumentos. 

La secuencia de puntuación `});` prevalece porque `describe` e `it` son funciones JavaScript de dos argumentos, el segundo de los cuales es una función sin argumentos. 

**Pregunta:** Experimenta el siguiente código de especificaciones (specs) de Jasmine del camino feliz del código AJAX llamado `movie_popup_spec.js`.

```
describe('MoviePopup', function() {
  describe('setup', function() {
    it('adds popup Div to main page', function() {
      expect($('#movieInfo')).toExist();
    });
    it('hides the popup Div', function() {
      expect($('#movieInfo')).toBeHidden();
    });
  });
  describe('clicking on movie link', function() {
    beforeEach(function() { loadFixtures('movie_row.html'); });
    it('calls correct URL', function() {
      spyOn($, 'ajax');
      $('#movies a').trigger('click');
      expect($.ajax.calls.mostRecent().args[0]['url']).toEqual('/movies/1');
    });
    describe('when successful server call', function() {
      beforeEach(function() {
        let htmlResponse = readFixtures('movie_info.html');
        spyOn($, 'ajax').and.callFake(function(ajaxArgs) { 
          ajaxArgs.success(htmlResponse, '200');
        });
        $('#movies a').trigger('click');
      });
      it('makes #movieInfo visible', function() {
        expect($('#movieInfo')).toBeVisible();
      });
      it('places movie title in #movieInfo', function() {
        expect($('#movieInfo').text()).toContain('Casablanca');
      });
    });
  });
});
```

**Pregunta** ¿Que hacen las siguientes líneas del código anterior?. ¿Cuál es el papel de `spyOn`  de Jasmine y los stubs en el código dado.

```
it('calls correct URL', function() {
      spyOn($, 'ajax');
      $('#movies a').trigger('click');
      expect($.ajax.calls.mostRecent().args[0]['url']).toEqual('/movies/1');
    });
```

**Pregunta:**¿Qupe hacen las siguientes líneas del código anterior?. 

```
 let htmlResponse = readFixtures('movie_info.html');
        spyOn($, 'ajax').and.callFake(function(ajaxArgs) { 
          ajaxArgs.success(htmlResponse, '200');
        });
        $('#movies a').trigger('click');
      });
      it('makes #movieInfo visible', function() {
        expect($('#movieInfo')).toBeVisible();
      });
      it('places movie title in #movieInfo', function() {
        expect($('#movieInfo').text()).toContain('Casablanca');

```
 
**Pregunta:** Dado que Jasmine carga todos los ficheros JavaScript antes de ejecutar ningún ejemplo, la llamada a `setup` (línea 34 del codigo siguiente llamado `movie_popup.js`)ocurre antes de que se ejecuten nuestras pruebas, comprueba que dicha función hace su trabajo y muestra los resultados.

```
var MoviePopup = {
  setup: function() {
    // add hidden 'div' to end of page to display popup:
    let popupDiv = $('<div id="movieInfo"></div>');
    popupDiv.hide().appendTo($('body'));
    $(document).on('click', '#movies a', MoviePopup.getMovieInfo);
  }
  ,getMovieInfo: function() {
    $.ajax({type: 'GET',
            url: $(this).attr('href'),
            timeout: 5000,
            success: MoviePopup.showMovieInfo,
            error: function(xhrObj, textStatus, exception) { alert('Error!'); }
            // 'success' and 'error' functions will be passed 3 args
           });
    return(false);
  }
  ,showMovieInfo: function(data, requestStatus, xhrObject) {
    // center a floater 1/2 as wide and 1/4 as tall as screen
    let oneFourth = Math.ceil($(window).width() / 4);
    $('#movieInfo').
      css({'left': oneFourth,  'width': 2*oneFourth, 'top': 250}).
      html(data).
      show();
    // make the Close link in the hidden element work
    $('#closeLink').click(MoviePopup.hideMovieInfo);
    return(false);  // prevent default link action
  }
  ,hideMovieInfo: function() {
    $('#movieInfo').hide();
    return(false);
  }
};
$(MoviePopup.setup);

```

**Pregunta:** Indica cuales son  los stubs y fixtures disponibles en Jasmine y Jasmine-jQuery. 

**Pregunta:** Como en RSpec, Jasmine permite ejecutar código de inicialización y desmantelamiento de pruebas utilizando `beforeEach` y `afterEach`.  El código de inicialización carga el fixture HTML mostrado en el código siguiente, para imitar el entorno que el manejador `getMovieInfo` vería si fuera llamado después de mostrar la lista de películas. 

```
<div id="movies">
  <div class="row">
    <div class="col-8"><a href="/movies/1">Casablanca</a></div>
    <div class="col-2">PG</div>
    <div class="col-2">1943-01-23</div>
  </div>
</div>
```


La funcionalidad de fixtures la proporciona Jasmine-jQuery, cada fixture se carga dentro de `div#jasmine-fixtures`, que está dentro de `div#jasmine_content` en la página principal de Jasmine, y todos los fixtures se eliminan después de cada especificación (spec) para preservar la independencia de las pruebas. 

**Pregunta:** Presenta tus resultados en clase. 

**Ejercicios**

1. Un inconveniente de la herencia de prototipos es que todos los atributos (propiedades) de los objetos son públicos. (Recuerda que en Ruby, ningún atributo era
público). Sin embargo, podemos aprovechar las clausuras para obtener atributos privados. Crea un sencillo constructor para los objetos `User` que acepte un nombre de usuario y una contraseña, y proporciona un método `checkPassword` que indique si la contraseña proporcionada es correcta, pero que deniegue la inspección de la contraseña en sí. Esta expresión de `sólo métodos de acceso` se usa ampliamente en jQuery.
2. SupongaMOS que no puede modificar el código del servidor para añadir la clase CSS `adult` a las filas de la tabla `movies`. ¿Cómo identificaría las filas que están ocultas utilizando sólo código JavaScript del lado cliente?
3. Escribe el código AJAX necesario para crear menús en cascada basados en una asociación `has_many`. Esto es, dados los modelos de Rails A y B, donde A `has_many` (tiene muchos) B, el primer menú de la pareja tiene que listar las opciones de A, y cuando se selecciona una, devolver las opciones de B correspondientes y rellenar el menú B.
4. Extienda la función de validación en ActiveModel para generar automáticamente código JavaScript que valide las entradas del formulario antes de que sea enviado. Por ejemplo, puesto que el modelo `Movie` de `RottenPotatoes` requiere que el título de cada película sea distinto de la cadena vacía, el código JavaScript debería evitar que el formulario `Add New Movie` se enviara si no se cumplen los criterios de validación, mostrar un mensaje de ayuda al usuario, y resaltar el(los) campo(s) del formulario que ocasionaron los problemas de validación. Gestiona, al menos, las validaciones integradas, como que los títulos sean distintos de cadena vacía, que las longitudes máxima y mínima de la cadena de caracteres sean correctas, que los valores numéricos estén dentro de los límites de los rangos, y para puntos adicionales, realiza las validaciones basándose en expresiones regulares.



