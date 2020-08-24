class Movie < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :ratings, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :hates, dependent: :destroy
  has_and_belongs_to_many :genres
  has_many :users, through: :ratings

  def data
    require 'json'
    require 'open-uri'
    url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB']}&i=".freeze
    HTTParty.get(url + imdb)
  end

  def evan_rating
    ratings.first.score
  end

  def case_rating
    ratings.last.score
  end

  def average
    (evan_rating + case_rating) / 2.to_f
  end

  def showtime
    hours = runtime / 60
    mins = runtime % 60
    if hours.zero?
      "#{mins}min"
    else
      "#{hours}h #{mins}min"
    end
  end

  def self.rated(num)
    list = []
    movies = Movie.all
    movies.each do |movie|
      list << movie if movie.average == num
    end
    list
  end
end
