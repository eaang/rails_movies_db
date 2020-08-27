class AddMovieAndUserIndexOnRatings < ActiveRecord::Migration[6.0]
  def change
    add_index :ratings, [:user_id, :movie_id], unique: true
  end
end
