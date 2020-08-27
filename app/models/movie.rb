class Movie < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :genres
  has_many :users, through: :ratings
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :imdb, uniqueness: true

  def data
    require 'json'
    require 'open-uri'
    url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB']}&i=".freeze
    HTTParty.get(url + imdb)
  end

  def evan_rating
    if ratings.where(user_id: 1).empty?
      false
    else
      ratings.where(user_id: 1).first
    end
  end

  def case_rating
    if ratings.where(user_id: 2).empty?
      false
    else
      ratings.where(user_id: 2).first
    end
  end

  def average
    if evan_rating && case_rating
      (evan_rating.score + case_rating.score) / 2.to_f
    else
      false
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
