# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'json'
require 'open-uri'
movie_url = 'https://www.dropbox.com/s/esyahi6uqdcq9bv/movies.csv?dl=1'
genre_url = 'https://www.dropbox.com/s/wkl4kk0svrba8wr/genres.csv?dl=1'

user1 = User.find_or_create_by(email: 'ang@test.com') do |user|
  user.password = 'password'
end

user2 = User.find_or_create_by(email: 'case@test.com') do |user|
  user.password = 'password'
end

movie_data = CSV.parse(open(movie_url), headers: :first_row)
genre_data = CSV.parse(open(genre_url), headers: :first_row)
api_url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB']}&t=".freeze

genre_data.each do |row|
  Genre.create(name: row[0].force_encoding('utf-8'), description: row[1].force_encoding('utf-8'))
  puts "Genre created: #{row[0]}!"
end

movie_data.each do |row|
  response = HTTParty.get(api_url + row[0])
  movie = Movie.create(
    name: response['Title'],
    description: response['Plot'],
    year: response['Year'],
    imdb: response['imdbID'],
    director: response['Director'],
    writer: response['Writer'],
    production: response['Production'],
    awards: response['Awards'],
    actors: response['Actors'],
    imdbrating: response['imdbRating'] == 'N/A' ? nil : response['imdbRating'],
    metascore: response['Metascore'] == 'N/A' ? nil : response['Metascore'],
    runtime: response['Runtime'][/(^\d*)/, 1].to_i,
    rated: response['Rated'],
    release: DateTime.parse(response['Released']),
    language: response['Language'],
    country: response['Country'],
    poster: response['Poster']
  )
  genres = response['Genre'].split(', ')
  genres.map! { |name| Genre.find_or_create_by(name: name) }
  genres.each do |genre|
    movie.genres << genre
  end
  Rating.create(
    [
      { score: row[2], user: user1, movie: movie },
      { score: row[3], user: user2, movie: movie }
    ]
  )
  puts "Movie created: #{movie.name}!"
end
