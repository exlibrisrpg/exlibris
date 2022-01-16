class CreateCurationRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :curation_roles, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :system, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
