class AddIconToTagCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :tag_categories, :icon, :integer
  end
end
