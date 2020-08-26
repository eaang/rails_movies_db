class FixActorsNameOnMovies < ActiveRecord::Migration[6.0]
  def change
    rename_column :movies, :actors, :stars
  end
end
