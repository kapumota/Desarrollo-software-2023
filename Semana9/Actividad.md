## Testing Java Script y Ajax

Para empezar a utilizar [Jasmine](https://jasmine.github.io/), añada `gem jasmine` a tu Gemfile y ejecute bundle como siempre; después, ejecuta los comandos siguientes desde el directorio raíz de su aplicación.

```
rails generate jasmine_rails:install 
mkdir spec/javascripts/fixtures 
curl https://raw.githubusercontent.com/velesin/jasmine-jquery/master/lib/jasmine-jquery.js > spec/javascripts/helpers/jasmine-jquery.js 
 
git add spec/javascripts 
```
