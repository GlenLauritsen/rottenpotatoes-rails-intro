class Movie < ActiveRecord::Base
    
    def Movie.ratings
       return ['G','PG','PG-13','R'] 
    end
    
    def Movie.with_ratings(ratings)
        return Movie.all.where('rating IN (?)', ratings.keys)
    end
    
end
