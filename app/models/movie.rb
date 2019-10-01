class Movie < ActiveRecord::Base
    
    def Movie.ratings
       return ['G','PG','PG-13','R'] 
    end
    
    def Movie.with_ratings(ratings)
        puts ratings
    end
    
end
