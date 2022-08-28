class Tag < ApplicationRecord
  extend FriendlyId

  has_and_belongs_to_many :entries, ->(tag) { by_name.where(system: tag.system) }
  belongs_to :tag_category, ->(tag) { where(system_id: tag.system_id) }
  belongs_to :system

  validates :name, :tag_category, :system, presence: true
  validates :short_description, presence: {if: -> { tag_category&.short_description_required }}

  friendly_id :name, use: :slugged
  has_rich_text :description

  default_scope { by_name }

  scope :by_name, proc { order('LOWER("tags"."name") asc') }
  scope :containing, ->(query) { where("unaccent(tags.name) ILIKE unaccent(:query)", query: "%#{query}%") }
  scope :with_includes, -> { includes(:rich_text_description, :tag_category, entries: [:links, :rich_text_description, tags: :rich_text_description, cover_attachment: :blob]) }

  scope :categories, ->(system) { where(tag_categories: system.tag_categories.where(name: "Categories")).reorder(:order) }
  scope :for_system, ->(system) { where(system: system) }

  class << self
    def suggestions_for(system)
      system.tags
        .joins("INNER JOIN tag_categories ON tags.tag_category_id = tag_categories.id")
        .select("tags.id AS value, tag_categories.name || ' > ' || tags.name AS label")
        .reorder(:label)
    end

    def labels_for(ids)
      joins("INNER JOIN tag_categories ON tags.tag_category_id = tag_categories.id")
        .select("tag_categories.name || ' > ' || tags.name AS label")
        .find(ids)
        .pluck(:label)
    end
  end

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
