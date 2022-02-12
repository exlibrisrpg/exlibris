class AddSystemReferenceToTagCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :tag_categories, :system, type: :uuid, null: true
  end
end
