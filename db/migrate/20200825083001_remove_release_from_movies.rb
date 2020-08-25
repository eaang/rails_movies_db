class RemoveReleaseFromMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :release, :date
  end
end
