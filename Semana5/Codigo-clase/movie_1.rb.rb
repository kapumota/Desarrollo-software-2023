# Correccion André Calagua
class Movie < ActiveRecord::Base
    private
    def movie_params
    params.require(:movie).permit( :title, :rating, :description, :release_date)
  end
end

#class Movie < ActiveRecord::Base
# attr_accessible :title, :rating, :description, :release_date
#end
