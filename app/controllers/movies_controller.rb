class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :stats ]

  def index
    @movies = Movie.all.includes(:genres).includes(:ratings)
    @title = 'All Movies'
  end

  def show
    @movie = Movie.friendly.find(params[:id])
    @wanted = %w[director writer actors production awards]
    @title = @movie.name
  end

  def new
    @movie = Movie.new
  end

  def stats
    @title = 'Statistics'
    @movies = Movie.all
    @genres = Genre.all
    @genres_and_movies = Genre.joins(:movies)
    ratings = Rating.all.includes(:users)
    @evan_reviews = ratings.where(user_id: 2)
    @case_reviews = ratings.where(user_id: 2)
    @top_rated = Movie.rated(5).sort_by { |e| e[:name] }
    @bottom_rated = Movie.rated(0).sort_by { |e| e[:name] }
  end
end
