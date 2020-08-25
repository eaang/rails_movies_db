class Movie < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :genres
  has_many :users, through: :ratings

  def data
    require 'json'
    require 'open-uri'
    url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB']}&i=".freeze
    HTTParty.get(url + imdb)
  end

  def evan_rating
    ratings.empty? ? 'N/A' : ratings.first.score
  end

  def case_rating
    ratings.empty? ? 'N/A' : ratings.last.score
  end

  def average
    if evan_rating == 'N/A' || case_rating == 'N/A'
      'N/A'
    else
      (evan_rating + case_rating) / 2.to_f
    end
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
