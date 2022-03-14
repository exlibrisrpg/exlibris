class AddLiveToSystems < ActiveRecord::Migration[7.0]
  def change
    add_column :systems, :live, :boolean, default: false, required: true
  end
end
