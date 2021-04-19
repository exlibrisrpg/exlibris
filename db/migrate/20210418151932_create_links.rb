class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links, id: :uuid do |t|
      t.belongs_to :entry, null: false, foreign_key: true, type: :uuid
      t.string :address

      t.timestamps
    end
  end
end
