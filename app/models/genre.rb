class Genre < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :movies

  def top_movies
    all_movies = []
    top_movies = []
    movies.each do |movie|
      all_movies << [movie, movie.average]
    end
    all_movies.sort_by { |mov| mov[1] }.last(3).each do |thing|
      top_movies << thing[0]
    end
    top_movies.sort_by(&:name)
  end
end
