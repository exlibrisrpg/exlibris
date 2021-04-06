class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
