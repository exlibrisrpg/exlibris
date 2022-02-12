class Tag < ApplicationRecord
  extend FriendlyId

  has_and_belongs_to_many :entries, ->(tag) { by_name.where(system: tag.system) }
  belongs_to :tag_category
  belongs_to :system, optional: true

  validates :name, :tag_category, presence: true
  validates :short_description, presence: {if: -> { tag_category&.short_description_required }}

  friendly_id :name, use: :slugged
  has_rich_text :description

  default_scope { by_name }

  scope :by_name, proc { order('LOWER("tags"."name") asc') }
  scope :containing, ->(query) { where("unaccent(tags.name) ILIKE unaccent(:query)", query: "%#{query}%") }
  scope :with_includes, -> { includes(:rich_text_description, :tag_category, entries: [:links, :rich_text_description, tags: :rich_text_description, cover_attachment: :blob]) }

  scope :categories, -> { includes(:tag_category).where(tag_categories: {name: "Categories"}).reorder(:order) }

  def creator?
    tag_category.name == "Creators"
  end

  def category?
    tag_category.name == "Categories"
  end

  def to_meta_tags
    {
      title: name,
      description: description.to_plain_text
    }
  end

  private

  def should_generate_new_friendly_id?
    super || name_changed?
  end
end
