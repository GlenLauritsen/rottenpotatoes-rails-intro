module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def movie_sort_by_name
    flash[:notice] = "Requested to Sort by Name"
  end
  
end
