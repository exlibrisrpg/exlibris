class AddOrderToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :order, :integer
  end
end
