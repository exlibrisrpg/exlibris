class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def up
    execute <<~SQL
      CREATE TYPE user_role AS ENUM ('admin', 'curator');
    SQL

    add_column :users, :role, :user_role, default: "curator", null: false
    add_index :users, :role
  end

  def down
    remove_index :users, :role
    remove_column :users, :role

    execute <<~SQL
      DROP TYPE user_role;
    SQL
  end
end
