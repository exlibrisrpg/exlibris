class Tag < ApplicationRecord
  extend FriendlyId

  has_and_belongs_to_many :entries, proc { by_name }
  belongs_to :tag_category

  validates :name, :tag_category, presence: true
  validates :short_description, presence: {if: -> { tag_category&.short_description_required }}

  friendly_id :name, use: :slugged
  has_rich_text :description

  scope :by_name, proc { order('LOWER("tags"."name") asc') }
  scope :containing, ->(query) { where("to_tsvector('en', tags.name) @@ websearch_to_tsquery(unaccent(:query))", query: query) }
  scope :with_includes, -> { includes(:rich_text_description, :tag_category, entries: [:links, :rich_text_description, tags: :rich_text_description, cover_attachment: :blob]) }

  scope :categories, -> { includes(:tag_category).where(tag_categories: {name: "Categories"}).reorder(:order) }

  def creator?
    tag_category.name == "Creators"
  end

  def category?
    tag_category.name == "Categories"
  end

  private

  def should_generate_new_friendly_id?
    super || name_changed?
  end
end
