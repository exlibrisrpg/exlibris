class AddTagCategoryReferenceToTags < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :tags, :tag_category, foreign_key: true, type: :uuid
  end
end
