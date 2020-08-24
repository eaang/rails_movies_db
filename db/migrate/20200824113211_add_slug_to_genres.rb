class AddSlugToGenres < ActiveRecord::Migration[6.0]
  def change
    add_column :genres, :slug, :string
    add_index :genres, :slug, unique: true
  end
end
