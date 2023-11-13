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
Se puede autenticar al usuario a través de un tercero. Usar la excelente gema OmniAuth que proporciona una API uniforme para muchos proveedores de SSO diferentes. 
El código siguiente muestra los cambios necesarios en sus rutas, controladores y vistas para usar OmniAuth.  

```
#routes.rb
get  'auth/:provider/callback' => 'sessions#create'
get  'auth/failure' => 'sessions#failure'
get  'auth/twitter', :as => 'login'
post 'logout' => 'sessions#destroy'
```

```
class SessionsController < ApplicationController
  # login & logout actions should not require user to be logged in
  skip_before_filter :set_current_user  # check you version
  def create
    auth = request.env["omniauth.auth"]
    user =
      Moviegoer.where(provider: auth["provider"], uid: auth["uid"]) ||
      Moviegoer.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to movies_path
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end
end
```
```
# Replace API_KEY and API_SECRET with the values you got from Twitter
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "API_KEY", "API_SECRET"
end
```

La mayoría de los proveedores de autenticación requieren que tu registre cualquier aplicación que utilizará su sitio para la autenticación, por lo que en este ejemplo necesitarás crear una cuenta de desarrollador de Twitter, que te asignará una clave API y un secreto API que especificarás en `config/initializers/ omniauth.rb` (codigo anterior, abajo).

**Pregunta:** Debes tener cuidado para evitar crear una vulnerabilidad de seguridad. ¿Qué sucede si un atacante malintencionado crea un envío de formulario que intenta modificar `params[:moviegoer][:uid]` o `params[:moviegoer][:provider]` (campos que solo deben modificarse mediante la lógica de autenticación) publicando campos de formulario ocultos denominados `params[moviegoer][uid]` y así sucesivamente?.

#### Asociaciones y claves foráneas 

Una asociación es una relación lógica entre dos tipos de entidades de una arquitectura software. 
Por ejemplo, podemos añadir a RottenPotatoes las clases Review (crítica) y Moviegoer (espectador o usuario) para permitir que los usuarios escriban críticas sobre sus películas favoritas; podríamos hacer esto añadiendo una asociación de uno a muchos (one-to-many) entre las críticas y las películas (cada crítica es acerca de una película) y entre críticas y usuarios (cada crítica está escrita por exactamente un usuario). 

Explica la siguientes líneas de SQL:

```
SELECT reviews.*
    FROM movies JOIN reviews ON movies.id=reviews.movie_id
    WHERE movies.id = 41;
```

Comprueba la implementación sencilla de asociaciones de hacer referencia directamente a objetos asociados, aunque estén almacenados en diferentes tablas de bases de datos. ¿Por que se puede hacer esto?

```
# it would be nice if we could do this:
inception = Movie.where(:title => 'Inception')
alice,bob = Moviegoer.find(alice_id, bob_id)
# alice likes Inception, bob less so
alice_review = Review.new(:potatoes => 5)
bob_review   = Review.new(:potatoes => 3)
# a movie has many reviews:
inception.reviews = [alice_review, bob_review]
# a moviegoer has many reviews:
alice.reviews << alice_review
bob.reviews << bob_review
# can we find out who wrote each review?
inception.reviews.map { |r| r.moviegoer.name } # => ['alice','bob']
```

Aplica los cambios del código siguiente y arranca `rails console` y ejecutar correctamente los ejemplos del código. 

(a): Crea y aplica esta migración para crear la tabla Reviews. Las claves foraneas del nuevo modelo están relacionadas con las tablas movies y moviegoers existentes por convención sobre la configuración. 

```
# Run 'rails generate migration create_reviews' and then
#   edit db/migrate/*_create_reviews.rb to look like this:
class CreateReviews < ActiveRecord::Migration
    def change
        create_table 'reviews' do |t|
        t.integer    'potatoes'
        t.text       'comments'
        t.references 'moviegoer'
        t.references 'movie'
        end
    end
end
```
b) Coloca este nuevo modelo de revisión en `app/models/review.rb`. 
```
class Review < ActiveRecord::Base
    belongs_to :movie
    belongs_to :moviegoer
end
```

c) Coloca una copia de la siguiente línea en cualquier lugar dentro de la clase Movie Y dentro de la clase `Moviegoer` (idiomáticamente, debería ir justo después de 'class Movie' o 'class Moviegoer'), es decir realiza este cambio de una línea en cada uno de los archivos existentes `movie.rb` y `moviegoer.rb`.

```
has_many :reviews
```

#### Asociaciones indirectas
Volviendo a la figura siguiente, vemos asociaciones directas entre Moviegoers y Reviews, así como entre Movies y Reviews.

<img src="https://e.saasbook.info/assets/Chapter5/5.9-1ff7ee5268d1af8d2bc0cd61ac7a0f113c248deb1188de757f86b0e192d9c2b2.jpg" alt="drawing" width="500"/>

Comprueba que el código muestra cómo se usa la opción `:through` en `has_many` para representar una asociación indirecta. De la misma manera, puede añadir `has_many:moviegoers,:through=>:reviews` al modelo `Movie` y escribir `movie.moviegoers` para preguntar qué usuarios están asociados con (escribieron críticas de) una película dada. 

```
# Run 'rails generate migration create_reviews' and then
#   edit db/migrate/*_create_reviews.rb to look like this:
class CreateReviews < ActiveRecord::Migration
    def change
        create_table 'reviews' do |t|
        t.integer    'potatoes'
        t.text       'comments'
        t.references 'moviegoer'
        t.references 'movie'
        end
    end
end
```

¿Qué indica el siguiente código SQL ?

```
SELECT movies .*
    FROM movies JOIN reviews ON movies.id = reviews.movie_id
    JOIN moviegoers ON moviegoers.id = reviews.moviegoer_id
    WHERE moviegoers.id = 1;
```
Se ha  añadido `has_many :reviews` a la clase `Movie`.  El método `has_many` utiliza la metaprogramación para definir el nuevo método de `instancia reviews=` que usamos en el código siguiente.     

```
# it would be nice if we could do this:
inception = Movie.where(:title => 'Inception')
alice,bob = Moviegoer.find(alice_id, bob_id)
# alice likes Inception, bob less so
alice_review = Review.new(:potatoes => 5)
bob_review   = Review.new(:potatoes => 3)
# a movie has many reviews:
inception.reviews = [alice_review, bob_review]
# a moviegoer has many reviews:
alice.reviews << alice_review
bob.reviews << bob_review
# can we find out who wrote each review?
inception.reviews.map { |r| r.moviegoer.name } # => ['alice','bob']
```

Las asociaciones representan uno de los aspectos de Rails con una funcionalidad completa así que eche una ojeada a su documentación completa. En concreto: 

* Al igual que el ciclo de vida de los hooks de ActiveRecord, las asociaciones ofrecen formas de intervención que se pueden lanzar cuando se añaden o se borran objetos de una asociación (como cuando se añaden nuevas Reviews a una Movie), y que son distintos del ciclo de vida de los hooks de  `Movies` o `Reviews` por separado.
* Las validaciones se pueden declarar en modelos asociados, como se muestra en el código.

```
class Review < ActiveRecord::Base
    # review is valid only if it's associated with a movie:
    validates :movie_id , :presence => true
    # can ALSO require that the referenced movie itself be valid
    # in order for the review to be valid:
    validates_associated :movie
end
```
* Como llamar a `save` o `save!` sobre un objeto que usa asociaciones también afecta a los objetos a los que esté asociado, se aplican algunas salvedades si alguno de estos métodos falla. Por ejemplo, si acabas de crear una nueva `Movie` y dos nuevas `Review que asociar a esa `Movie`, e intenta guardar dicha película, cualquiera de los tres métodos save que se apliquen fallarán si los objetos no son válidos (entre otras razones).  !Comprueba esto!.

* Existen opciones adicionales en los métodos de asociaciones que controlan lo que pasa a los objetos que son “tenidos” cuando el objeto “poseedor” se destruye. Por ejemplo, `has_many :reviews,:dependent=>:destroy` especifica que las críticas que pertenezcan a una determina película se deben borrar de la base de datos si se borra esa película.
