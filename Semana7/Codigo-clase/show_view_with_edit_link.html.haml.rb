-# modify last 2 lines of app/views/movies/show.html.haml to:
= link_to 'Edit info', edit_movie_path(@movie)
= link_to 'Back to movie list', movies_path