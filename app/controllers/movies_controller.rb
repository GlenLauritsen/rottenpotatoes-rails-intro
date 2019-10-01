class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:commit] != "Refresh"
      if !params[:order]
        params[:order] = session[:order]
      end
      
      if session[:ratings]
        params[:ratings] = session[:ratings]
      elsif !params[:ratings]
        params[:ratings] = {"G"=>"G", "PG"=>"PG", "PG-13"=>"PG-13", "R"=>"R"}
      end
    end
    
    if !params[:ratings]
      params[:ratings] = session[:ratings]
    end
    @checkboxesChecked = params[:ratings].keys
    @all_ratings = Movie.ratings
    @movies = Movie.with_ratings(params[:ratings])
    
    puts params[:order]
    
    if params[:order] == 'title'
      @movies = @movies.order('title')
      @titleHeader = 'hilite'
    elsif params[:order] == 'release_date'
      @movies = @movies.order('release_date')
      @releaseHeader = 'hilite'
    end
    
    session[:ratings] = params[:ratings]
    session[:order] = params[:order]
  end
  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    
    redirect_to movies_path
  end

end
