class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :stats ]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :new_movie, only: [:new, :create]

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
    @wanted = %w[director writer stars production awards]
    @title = @movie.name
    @partner = User.where.not(id: current_user).first
    if @partner.id == 1
      @my_score = @movie.case_rating
      @partner_score = @movie.evan_rating
    else
      @my_score = @movie.evan_rating
      @partner_score = @movie.case_rating
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "#{@movie.name} was successfully updated."
    else
      render @movie
    end
  end

  def new
  end

  def create
    movie = Movie.new(movie_params.except(:mine, :partner))
    add_genres(params[:movie]["genres"], movie)
    if movie.save
      rate_movie(movie, params[:movie][:mine], params[:movie][:partner])
      redirect_to movie, notice: "#{movie.name} was successfully created."
    else
      redirect_to new_movie_path, notice: movie.errors.full_messages.first
    end
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

  def add_genres(list, movie)
    list.split(', ').each do |genre|
      movie.genres << Genre.find_or_create_by(name: genre)
    end
  end

  def rate_movie(movie, my_score, partner_score)
    Rating.create({ score: my_score.to_i, user: current_user, movie: movie }) if integer?(my_score)
    return unless integer?(partner_score)

    Rating.create({ score: partner_score.to_i, user: User.where.not(id: current_user).first, movie: movie })
  end

  def integer?(str)
    !!(str =~ /^-?\d+(\.\d*)?$/)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.friendly.find(params[:id])
  end

  def new_movie
    @movie = Movie.new
    @user = current_user
    @partner = User.where.not(id: @user.id).first
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
