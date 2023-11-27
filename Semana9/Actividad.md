## Testing Java Script y Ajax

Para empezar a utilizar [Jasmine](https://jasmine.github.io/), añada `gem jasmine` a tu Gemfile y ejecute bundle como siempre; después, ejecuta los comandos siguientes desde el directorio raíz de su aplicación.

```
rails generate jasmine_rails:install 
mkdir spec/javascripts/fixtures 
curl https://raw.githubusercontent.com/velesin/jasmine-jquery/master/lib/jasmine-jquery.js
    > spec/javascripts/helpers/jasmine-jquery.js 
git add spec/javascripts 
```

No podemos ejecutar un conjunto de pruebas Jasmine completamente vacío, así que crea el fichero `spec/javascripts/basic_check_spec.js` con el siguiente código: 

```
describe ('Jasmine basic check', function() { 
    it('works', function() { expect(true).toBe(true); }); 
}); 
```
Para ejecutar pruebas de Jasmine, simplemente inicia tu aplicación con el comando `rails server` y, una vez que se esté ejecutando, busca el subdirectorio `spec` de tu aplicación (por ejemplo, http://localhost:3000/specs si desarrollas la actividad en tu propia computadora) para ejecutar todas las especificaciones y ver los resultados. 

**Importante:** De ahora en adelante, cuando cambies cualquier código en `app/assets/javascripts` o pruebas en `spec/javascripts`, simplemente vuelve a cargar la página del navegador para volver a ejecutar todas las pruebas. 

**Pregunta:** ¿Cuáles son los problemas que se tiene cuando se debe probar Ajax?. Explica tu respuesta.

**Pregunta:** ¿Qué son los stubs y fixture en Jasmine para realizar pruebas de Ajax?

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



