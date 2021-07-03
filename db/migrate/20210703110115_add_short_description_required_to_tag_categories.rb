class AddShortDescriptionRequiredToTagCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :tag_categories, :short_description_required, :boolean, default: false
  end
end
