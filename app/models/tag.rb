class Tag < ApplicationRecord
  has_and_belongs_to_many :entries
  belongs_to :tag_category

  validates :name, :tag_category, presence: true

  scope :containing, ->(query) { where("to_tsvector('en', tags.name) @@ websearch_to_tsquery(unaccent(:query))", query: query) }
  scope :with_includes, -> { includes(entries: [:links, :tags, :rich_text_description, cover_attachment: :blob]) }
end
