class AddSystemReferenceToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :system, type: :uuid, null: true
  end
end
