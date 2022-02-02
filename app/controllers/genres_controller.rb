class GenresController < ApplicationController

    before_action :require_admin, except: [:show, :index]
    before_action :set_genre, only: [:show, :edit, :update, :destroy]

    def new
        @genre = Genre.new
    end

    def create
        @genre = Genre.new(genre_params)
        if @genre.save
            flash[:notice] = "Genre succesfully created"
            redirect_to genres_path
        else
            render :new
        end
    end

    def edit
        
    end

    def update
        if @genre.update(genre_params)
            flash[:notice] = "Genre succesfully updated"
            redirect_to genres_path 
        else
            render :edit
        end
    end

    def destroy
        @genre.destroy
        
        redirect_to genres_path, alert: "Genre succesfully deleted"
    end

    def index
        @genres = Genre.all
    end

    def show
        @movies = @genre.movies
    end

    private
        def genre_params
            params.require(:genre).permit(:name)
        end

        def set_genre
            @genre = Genre.find_by!(slug: params[:id])
        end

end
