class AddSystemReferencesToEntries < ActiveRecord::Migration[7.0]
  def change
    add_reference :entries, :system, type: :uuid, null: true
  end
end
