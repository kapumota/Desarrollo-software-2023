# in movies_controller.rb
def create
  @movie = Movie.create!(params[:movie])
  redirect_to movies_path
end