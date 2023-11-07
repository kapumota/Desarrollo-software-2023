%h2 Edit Movie

= form_tag movie_path(@movie), :method => :put do

  = label :movie, :title, 'Title'
  = text_field :movie, 'title'

  = label :movie, :rating, 'Rating'
  = select :movie, :rating, ['G','PG','PG-13','R','NC-17']
 
  = label :movie, :release_date, 'Released On'
  = date_select :movie, :release_date

  = submit_tag 'Save Changes'