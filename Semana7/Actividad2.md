### Ruby en Rails avanzado

En esta actividad, seguirás utilizando un repositorio llamado Rails-Avanzado y presentarás en clase tus resultados. 
Utiliza https://github.com/kapumota/Desarrollo-software-2023/tree/main/Semana7/myrottenpotatoes.

#### Rutas REST para asociaciones 
¿Cómo debemos referirnos, de manera REST, a las acciones asociadas a las críticas de películas?
En particular, al menos cuando creamos o modificamos una crítica, necesitamos una manera de enlazarla con un usuario y una película. Presumiblemente, el espectador será el
`@current_user`. Pero, ¿qué pasa con la película?

Como sólo tiene sentido crear una reseña cuando tienes una película en mente, la funcionalidad "Create Review" estará accesible a través de un botón o enlace en la página de 
detalles de una película dada, "Show Movie Details". Por tanto, en el momento en que mostramos este control, sabemos a qué película va a estar asociada la crítica. La cuestión es cómo hacer llegar esta
información a los métodos `new` o `create` en el controlador `ReviewsController`.


Una forma es, cuando el usuario visita la página de detalles de una película, usar el objeto `session[]` (que persiste entre peticiones) para recordar 
el ID de la película cuyos detalles acabamos de ver, pasando a considerarla la película actual (`current movie`). Cuando se llama a `ReviewsController#new`, recuperaremos el 
ID del objeto `session[]` y lo asociaremos con la crítica poblando una campo de formulario escondido en esta reseña, que a su vez estará
disponible en `ReviewsController#create` .

**Pregunta:** ¿Este enfoque este de tipo REST? ¿por qué?

Una altermativa más REST, que deja explícito el ID de la película, consiste en hacer que las rutas REST en sí mismas reflejen el “anidamiento” lógico de las `Reviews` en `Movies`:

```
# in routes.rb, change the line 'resources :movies' to:
resources :movies do
resources :reviews
end
```
Como `Movie` está en el extremo “poseedor” dentro de la asociación, es el recurso exterior,de fuera. Al igual que `resources :movies`, que ofrecía un conjunto de métodos helper 
para los URI tipo REST que representasen acciones CRUD en las películas, **la especificación de rutas anidadas de recursos ofrece un conjunto de métodos helper para URI tipo REST para
acciones CRUD en reseñas pertenecientes a una película** . 

**Ejercicio:** Realice los cambios de arriba en `routes.rb` y ejecuta `rake routes`, comparando la salida de las rutas básicas dadas en clase.
La figura siguiente resume las nuevas rutas, que son ofrecidas junto a las rutas básicas REST de `Movies` que ya hemos estado usando todo el tiempo. 

<img src="https://e.saasbook.info/assets/Chapter5/5.17-36a5d6a9405f182fb2988d545813d5554f7e5c96b2dce25cb38a607e9189eb29.jpg" alt="drawing" width="500"/>


Nota que a través de la convención sobre configuración, el comodín `:id` en el URI hará que coincida el ID del recurso propiamente dicho, es decir, el ID de una crítica 
y Rails elige el nombre del recurso “externo” para hacer que `:movie_id` capture la ID del recurso “poseedor” . Así, los
valores de los ID estarán disponibles en las acciones del controlador como `params[:id]` (la crítica) y `params[:movie_id]` (la película con la que se asociará la crítica).

**Ejercicio:** El código  muestra un pequeño ejemplo de estas rutas anidadas para la creación de vistas y acciones asociadas a una nueva crítica. Explica su funcionamiento.

```
class ReviewsController < ApplicationController
    before_filter :has_moviegoer_and_movie , :only => [:new, :create]
    protected
    def has_moviegoer_and_movie
        unless @current_user
            flash[:warning] = 'You must be logged in to create a review.'
            redirect_to login_path
        end
        unless (@movie = Movie.where(:id => params[:movie_id]))
            flash[:warning] = 'Review must be for an existing movie.'
            redirect_to movies_path
        end
    end

    public
    def new
        @review = @movie.reviews.build
    end

    def create
    # since moviegoer_id is a protected attribute that won't get
    # assigned by the mass-assignment from params[:review], we set it
    # by using the << method on the association. We could also
    # set it manually with review.moviegoer = @current_user.
    @current_user.reviews << @movie.reviews.build(params[:review])
    redirect_to movie_path(@movie)
    end
end
```

```
<h1> New Review for <%= @movie.title %> </h1>

<%= form_tag movie_reviews_path(@movie), class: 'form' do %>
    <label class="col-form-label"> How many potatoes:</label>
    <%= select_tag 'review[potatoes]', options_for_select(1..5), class: 'form-control' %>
    <%= submit_tag 'Create Review', :class => 'btn btn-success' %>
<% end 
```

o

```
%h1 New Review for #{@movie.title}

= form_tag movie_reviews_path(@movie) do
  %label How many potatoes:
  = select_tag 'review[potatoes]', options_for_select(1..5)
  = submit_tag 'Create Review'
```

**Pregunta:** ¿Por qué tenemos que dar valores a los campos `movie_id` y `movie-goer_id` de una crítica en las acciones `new` y `create` de `ReviewsController`, pero no en las acciones `edit` o `update`?. 

#### Repaso

1. Al realizar una consulta de base de datos como `@reviews = Review.where(rating: 5)`​, que luego llamamos `​@reviews.each haz |review| ; review.moviegoers.first` ​que debemos hacer?
2. Supongamos que queremos agregar un modelo `Theaters` a Rotten Potatoes, con la suposición simplificadora de que cada `Theater (cine)` muestra solo una película en un momento dado, pero para una `Movie` determinada podría proyectarse en muchos `Theater`. Además de agregar una tabla `theaters` a la base de datos, ¿qué pasos son necesarios para que `movie.theaters` devuelva una lista de todos los cines en los que se proyecta una película?.
3. Suponiendo que una película tiene muchas reseñas, una reseña pertenece a una sola película y existe el ID de película 5, ¿qué tablas se actualizarán como resultado del siguiente código?

   ```
    m = Movie.find(5)
    m.reviews.build(:potatoes => 5)
    m.save!
   ```
