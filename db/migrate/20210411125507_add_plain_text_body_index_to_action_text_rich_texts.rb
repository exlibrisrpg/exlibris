class AddPlainTextBodyIndexToActionTextRichTexts < ActiveRecord::Migration[6.1]
  def change
    change_table :action_text_rich_texts do |t|
      t.text :plain_text_body, size: :long

      t.index "to_tsvector('english', plain_text_body)", using: :gin, name: "tsvector_plain_text_body_idx"
    end
  end
end
