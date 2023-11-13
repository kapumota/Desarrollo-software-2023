### Ruby en Rails avanzado

En esta actividad grupal, construiras un repositorio llamado Rails-Avanzado y presentarás en clase tus resultados. 
El código dado tiene algunos errores en la lógica del proceso del uso de frameworks y presente casi todos los tópicos avanzados en clase.

#### Vistas parciales, validaciones y filtros

Una vista parcial es el nombre de Rails para una parte reutilizable de una vista. Cuando debe aparecer contenido similar en diferentes vistas, colocar ese contenido en una 
parte e “incluirlo” en archivos separados ayuda a DRY la repetición. 

```
<!--  ...other code from index.html.erb here... -->
<div class="row bg-dark text-white">
    <div class="col-6 text-center">Title and More Info</div>
    <div class="col-2 text-center">Rating</div>
    <div class="col-4 text-center">Release Date</div>
</div>
<%= render partial: 'movie', collection: @movies %>
```
```
<div class="row">
    <div class="col-8"> <%= link_to movie.title, movie_path(movie) %> </div>
    <div class="col-2"> <%= movie.rating %> </div>
    <div class="col-2"> <%= movie.release_date.strftime('%F') %> </div>
</div>
```

Aprovecha la convención sobre la configuración, y llama al archivo `_movie.html.erb`, ¿que pasa con haml que se estuvo utilizando? : Rails usa el nombre del archivo (sin el guión bajo) para establecer 
una variable local (película) para cada elemento de la colección `@movies` por turno.
Una vista parcial puede estar en un directorio diferente al de la vista que lo usa, en cuyo caso una ruta como 'layouts/footer' haría que Rails busque 
app/views/layouts/_footer.html.erb.

Las validaciones de modelos, al igual que las migraciones, se expresan en un mini-DSL integrado en Ruby, como muestra en el siguiente código.  Escribe el código siguiente en el
código dado.

```
class Movie < ActiveRecord::Base
    def self.all_ratings ; %w[G PG PG-13 R NC-17] ; end #  shortcut: array of strings
    validates :title, :presence => true
    validates :release_date, :presence => true
    validate :released_1930_or_later # uses custom validator below
    validates :rating, :inclusion => {:in => Movie.all_ratings},
        :unless => :grandfathered?
    def released_1930_or_later
        errors.add(:release_date, 'must be 1930 or later') if
        release_date && release_date < Date.parse('1 Jan 1930')
    end
    @@grandfathered_date = Date.parse('1 Nov 1968')
    def grandfathered?
        release_date && release_date < @@grandfathered_date
    end
end
```

y comprueba tus resultados en la consola:

```
m = Movie.new(:title => '', :rating => 'RG', :release_date => '1929-01-01')
# force validation checks to be performed:
m.valid?  # => false
m.errors[:title] # => ["can't be blank"]
m.errors[:rating] # => [] - validation skipped for grandfathered movies
m.errors[:release_date] # => ["must be 1930 or later"]
m.errors.full_messages # => ["Title can't be blank", "Release date must be 1930 or later"]
```

Explica el código siguiente :

```
class MoviesController < ApplicationController
  # 'index' and 'show' methods from Section 4.4 omitted for clarity
  def new
    @movie = Movie.new
  end 
  def create
    if (@movie = Movie.create(movie_params))
      redirect_to movies_path, :notice => "#{@movie.title} created."
    else
      flash[:alert] = "Movie #{@movie.title} could not be created: " +
        @movie.errors.full_messages.join(",")
      render 'new'
    end
  end
  def edit
    @movie = Movie.find params[:id]
  end
  def update
    @movie = Movie.find params[:id]
    if (@movie.update_attributes(movie_params))
      redirect_to movie_path(@movie), :notice => "#{@movie.title} updated."
    else
      flash[:alert] = "#{@movie.title} could not be updated: " +
        @movie.errors.full_messages.join(",")
      render 'edit'
    end
  end
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, :notice => "#{@movie.title} deleted."
  end
  private
  def movie_params
    params.require(:movie)
    params[:movie].permit(:title,:rating,:release_date)
  end
end
```
Comprueba que el código siguiente ilustra cómo utilizar este mecanismo para “canonicalizar” (estandarizar el formato de) ciertos campos del modelo antes de guardar el modelo. 

```
class Movie < ActiveRecord::Base
    before_save :capitalize_title
    def capitalize_title
        self.title = self.title.split(/\s+/).map(&:downcase).
        map(&:capitalize).join(' ')
    end
end
```
Comprueba en la consola :

```
m = Movie.create!(:title => 'STAR  wars', :release_date => '27-5-1977', :rating => 'PG')
m.title  # => "Star Wars"
```

Análogo a una validación es un filtro de controlador: un método que verifica si ciertas condiciones son verdaderas antes de ejecutar una acción o establece condiciones comunes en las que dependen muchas acciones. Si no se cumplen las condiciones, el filtro puede optar por "detener la presentación" mostrando una plantilla de vista o redirigiendo a otra acción. Si el filtro permite que la acción continúe, será responsabilidad de la acción dar una respuesta, como es habitual. 

Por ejemplo, un uso extremadamente común de los filtros es imponer el requisito de que un usuario inicie sesión antes de poder realizar determinadas acciones. El código  muestra un filtro que exige que un usuario válido ha iniciado sesión. Comprueba el resultado del código.

```
class ApplicationController < ActionController::Base
    before_filter :set_current_user
    protected # prevents method from being invoked by a route
    def set_current_user
        # we exploit the fact that the below query may return nil
        @current_user ||= Moviegoer.where(:id => session[:user_id])
        redirect_to login_path and return unless @current_user
    end
end
```

#### SSO y autenticación a través de terceros 

Una manera de ser más DRY y productivo es evitar implementar funcionalidad que se puede reutilizar a partir de otros servicios. 
Un ejemplo muy actual de esto es la autenticación. 

Afortunadamente, añadir autenticación en las aplicaciones Rails a través de terceros es algo directo. Por supuesto, antes de que permitamos iniciar sesión a un usuario, ¡necesitamos poder representar usuarios! Así que antes de continuar, vamos a crear un modelo y una migración básicos siguiendo las instrucciones del código  siguiente:

a) Escribe este comando en una terminal para crear un modelo moviegoers y una migración, y ejecuta rake db:migrate para aplicar la migración. 

```
rails generate model Moviegoer name:string provider:string uid:string
```
b) Luego edita el archivo `app/models/moviegoer.rb` generado para que coincida con este código. 

```
# Edit app/models/moviegoer.rb to look like this:
class Moviegoer < ActiveRecord::Base
    def self.create_with_omniauth(auth)
        Moviegoer.create!(
        :provider => auth["provider"],
        :uid => auth["uid"],
        :name => auth["info"]["name"])
    end
end
```
