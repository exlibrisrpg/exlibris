class AddCaseInsensitiveNameOrderingIndexToEntries < ActiveRecord::Migration[6.1]
  def change
    add_index :entries, "LOWER(name)"
  end
end
