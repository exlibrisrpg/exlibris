class MakeEntriesSystemReferenceNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :entries, :system_id, false
  end
end
