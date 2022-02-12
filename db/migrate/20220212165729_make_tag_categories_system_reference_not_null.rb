class MakeTagCategoriesSystemReferenceNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tag_categories, :system_id, false
  end
end
