class AddSlugToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :slug, :string
    add_index :entries, :slug, unique: true
  end
end
