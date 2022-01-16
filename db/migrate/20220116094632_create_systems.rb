class CreateSystems < ActiveRecord::Migration[7.0]
  def change
    create_table :systems, id: :uuid do |t|
      t.string :name, required: true
      t.string :slug

      t.timestamps

      t.index :slug, unique: true
    end
  end
end
