class AddPositionToLinksTable < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :position, :integer

    up_only do
      execute <<~SQL.squish
        UPDATE links
        SET position = mapping.new_position
        FROM (
          SELECT
            id,
            ROW_NUMBER() OVER (
              PARTITION BY entry_id
              ORDER BY updated_at
            ) as new_position
          FROM links
        ) AS mapping
        WHERE links.id = mapping.id;
      SQL
    end
  end
end
