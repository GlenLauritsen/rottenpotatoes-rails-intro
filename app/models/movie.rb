class Movie < ActiveRecord::Base
    
    def getRatings
       return ['G','PG','PG-13','R'] 
    end
    
end
