class AddShortDescriptionToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :short_description, :text
  end
end
