class AddSearchIndexes < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<~SQL
          CREATE TEXT SEARCH CONFIGURATION en ( COPY = english );
          ALTER TEXT SEARCH CONFIGURATION en ALTER MAPPING
          FOR hword, hword_part, word WITH unaccent, english_stem;
        SQL
      end

      dir.down do
        execute "DROP TEXT SEARCH CONFIGURATION en;"
      end
    end

    reversible do |dir|
      change_table :action_text_rich_texts do |t|
        dir.up do
          t.remove_index name: "tsvector_plain_text_body_idx"
          t.index "to_tsvector('en', plain_text_body)", using: :gin, name: "tsvector_plain_text_body_idx"
        end

        dir.down do
          t.remove_index name: "tsvector_plain_text_body_idx"
          t.index "to_tsvector('english', plain_text_body)", using: :gin, name: "tsvector_plain_text_body_idx"
        end
      end
    end

    reversible do |dir|
      dir.up do
        add_index :entries, "to_tsvector('en', name)", using: :gin, name: "index_entries_tsvector_name"
        add_index :tags, "to_tsvector('en', name)", using: :gin, name: "index_tags_tsvector_name"
      end
      dir.down do
        remove_index :entries, name: "index_entries_tsvector_name"
        remove_index :tags, name: "index_tags_tsvector_name"
      end
    end
  end
end
