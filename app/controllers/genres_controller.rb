class GenresController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @title = 'All Genres'
    @genres = Genre.includes([:genres_movies]).includes([:movies]).joins([:movies]).distinct.sort_by { |e| e[:name] }
  end

  def show
    @genre = Genre.friendly.find(params[:id])
    @movies = @genre.movies.includes([:genres])
    @title = @genre.name + ' (genre)'
  end
end
