class AddTaglineToSystem < ActiveRecord::Migration[7.0]
  def change
    add_column :systems, :tagline, :text, default: "A directory of content, tools, and resources"
    change_column_default :systems, :tagline, nil
  end
end
