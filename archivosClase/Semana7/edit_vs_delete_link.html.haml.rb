-# Our Edit link from previous example:
= link_to 'Edit info', edit_movie_path(@movie)
-# This Delete link will not really be a link, but a form:
= link_to 'Delete', movie_path(@movie), :method => :delete