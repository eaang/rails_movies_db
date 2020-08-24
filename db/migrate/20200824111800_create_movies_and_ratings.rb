class CreateMoviesAndRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.integer :year
      t.string :imdb
      t.string :director
      t.text :writer
      t.string :production
      t.text :awards
      t.text :actors
      t.float :imdbrating
      t.float :metascore
      t.integer :runtime
      t.string :rated
      t.datetime :release
      t.string :language
      t.string :country
      t.string :poster

      t.timestamps
    end

    create_table :ratings do |t|
      t.integer  :score
      t.timestamps
    end

    create_table :genres do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_join_table :movies, :genres do |t|
      # t.index [:movie_id, :genre_id]
      # t.index [:genre_id, :movie_id]
    end

    add_reference :ratings, :user, null: false, foreign_key: true
    add_reference :ratings, :movie, null: false, foreign_key: true
  end
end
