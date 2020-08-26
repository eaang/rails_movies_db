class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :stats ]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def data(title)
    require 'csv'
    require 'json'
    require 'open-uri'
    api_url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB']}&t=".freeze
    search = title.gsub('&', '%26').gsub(' ', '+')
    HTTParty.get(api_url + search.to_s)
  end

  def index
    @movies = Movie.all.includes(:genres).includes(:ratings)
    @title = 'All Movies'
  end

  def show
    @wanted = %w[director writer actors production awards]
    @title = @movie.name
  end

  def new
    @movie = Movie.new
    @user = current_user
    @partner = User.where.not(id: @user.id).first
  end

  def create
    movie = Movie.new(movie_params.except(:mine, :partner))
    genres = params[:movie]["genres"].split(', ')
    genres.each { |name| movie.genres << Genre.find_or_create_by(name: name) }
    if movie.save
      set_ratings(movie, params[:movie][:mine], params[:movie][:partner])
      redirect_to movie, notice: "#{movie.name} was successfully created."
    else
      render :new
    end
  end

  def set_ratings(movie, my_score, partner_score)
    return Rating.create({ score: my_score.to_i, user: current_user, movie: movie }) if my_score.to_i == my_score
    return nil unless partner_score.to_i == partner_score

    Rating.create({ score: partner_score.to_i, user: User.where.not(id: current_user).first, movie: movie })
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "#{@movie.name} was successfully deleted."
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(
      :name, :description, :year, :imdb, :director, :writer,
      :production, :awards, :actors, :imdbrating, :metascore, :runtime,
      :rated, :language, :country, :poster, :mine, :partner
    )
  end
end
