class Entry < ApplicationRecord
  extend FriendlyId

  DEFAULT_DESCRIPTION = <<~HTML
    <div>
      <strong>Concept:</strong> <br>
      <strong>Content:</strong> <br>
      <strong>Writing:</strong> <br>
      <strong>Art/design:</strong> <br>
      <strong>Usability:</strong>&nbsp;
    </div>
  HTML

  belongs_to :system, optional: false
  has_and_belongs_to_many :tags, ->(entry) { where(system: entry.system) }
  has_many :links, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :system, presence: true
  validate :description_not_default

  friendly_id :name, use: :slugged
  has_one_attached :cover
  has_rich_text :description

  accepts_nested_attributes_for :links, allow_destroy: true, reject_if: :all_blank

  scope :by_name, proc { order('LOWER("entries"."name") asc') }
  scope :containing, ->(query) { content_containing(query).or(name_containing(query)) }
  scope :content_containing, ->(query) { joins(:rich_text_description).merge(ActionText::RichText.with_body_containing(query)) }
  scope :name_containing, ->(query) { where("to_tsvector('en', entries.name) @@ websearch_to_tsquery(unaccent(:query))", query: query) }
  scope :with_includes, -> { includes(:cover_blob, :links, rich_text_description: {embeds_attachments: :blob}, tags: [:rich_text_description, :tag_category], cover_attachment: :blob) }
  scope :with_tags, ->(filter_tag_ids) { where(id: Entry.joins(:entries_tags).where(entries_tags: {tag_id: filter_tag_ids}).group(:id).having("COUNT(entries.*) = ?", filter_tag_ids.size)) }

  def category_tags
    tags.with_includes.where(tag_category: TagCategory.find_by(name: "Categories", system: system))
  end

  def to_meta_tags
    {
      title: name,
      description: description.to_plain_text
    }.tap do |meta_tags|
      meta_tags[:image_src] = cover.url if cover.attached?
    end
  end

  private

  def description_not_default
    return if description.nil?
    return if description.body.to_plain_text.squish !=
      ActionText::Content.new(DEFAULT_DESCRIPTION).to_plain_text.squish

    errors.add(:description, :default)
  end

  def should_generate_new_friendly_id?
    super || name_changed?
  end
end
