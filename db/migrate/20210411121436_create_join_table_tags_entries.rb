class CreateJoinTableTagsEntries < ActiveRecord::Migration[6.1]
  def change
    create_join_table :tags, :entries, column_options: {type: :uuid} do |t|
      t.index [:tag_id, :entry_id]
      t.index [:entry_id, :tag_id]
    end
  end
end
