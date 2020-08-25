class ChangeDatetimeToDateOnMovies < ActiveRecord::Migration[6.0]
  def change
    change_column :movies, :release, :date
  end
end
