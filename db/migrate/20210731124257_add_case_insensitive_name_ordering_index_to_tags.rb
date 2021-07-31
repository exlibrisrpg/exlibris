class AddCaseInsensitiveNameOrderingIndexToTags < ActiveRecord::Migration[6.1]
  def change
    add_index :tags, "LOWER(name)"
  end
end
