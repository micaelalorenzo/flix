class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show]    
    before_action :require_admin, except: [:index, :show]
    before_action :set_movie, only: [:show, :update, :edit, :destroy]

    def index
        @movies = ["Iron Man", "Superman",  "Spider-Man", "Harry Potter"]
        #array de las peliculas en la bd
        @moviesBD = Movie.send(movies_filter)



        #case params[:filter]
        #when "upcoming"
        #    @moviesBD = Movie.upcoming
        #when "recent"
        #    @moviesBD = Movie.recent
        #when "hits"
        #    @moviesBD = Movie.hits
        #when "flops"
        #    @moviesBD = Movie.flop
        #else
        #    @moviesBD = Movie.released
        #end


    end

    def show
        
        @review = @movie.reviews.build
        @fans = @movie.fans
        @genres = @movie.genres.order(:name)

        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end

    end

    def edit
    end

    def update
        if @movie.update(movie_params)
            redirect_to @movie, notice: "Movie succesfully updated"
        else
            render :edit
        end

    end

    def new
        @movie = Movie.new
    end

    def create

        @movie = Movie.new(movie_params)
        if @movie.save
            flash[:notice] = "Movie succesfully created"
            redirect_to @movie
        else 
            render :new
        end

    end

    def destroy
        @movie.destroy
        redirect_to movies_path, alert: "Movie succesfully deleted"
    end

private 
    def set_movie
        @movie = Movie.find_by!(slug: params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title, :description, :rating, :released_on, :director, :duration, :total_gross, :image_file_name, genre_ids: [])   
    end

    def movies_filter
        if params[:filter].in? %w(upcoming recent hits flops)
          params[:filter]
        else
          :released
        end
    end



end
