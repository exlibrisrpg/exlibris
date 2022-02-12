class MakeTagsSystemReferenceNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tags, :system_id, false
  end
end
