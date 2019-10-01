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
    # reload session or update session
    puts params
    
    @checkboxesChecked = Movie.ratings
    
    if @refresh_session == true
      puts "Reloading Session"
      params[:ratings] = session[:ratings]
      params[:order] = session[:order]
      
      @refresh_session = false;
    end
    
    @movies = Movie.with_ratings(params[:ratings])
    @all_ratings = Movie.ratings
    
    if params[:order]
      if params[:order] == 'title'
        @movies = Movie.all.order('title')
      elsif params[:order] == 'release_date'
        @movies = Movie.all.order('release_date')
      end
    end
    
    if params[:ratings]
      @checkboxesChecked = params[:ratings].keys
    end
    
    session[:params] = params
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
