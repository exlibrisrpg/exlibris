class Entry < ApplicationRecord
  DEFAULT_DESCRIPTION = <<~HTML
    <div>
      <strong>Concept:</strong> <br>
      <strong>Content:</strong> <br>
      <strong>Writing:</strong> <br>
      <strong>Art/design:</strong> <br>
      <strong>Usability:</strong>&nbsp;
    </div>
  HTML

  has_and_belongs_to_many :tags

  validates :name, presence: true
  validates :description, presence: true
  validate :description_not_default

  has_one_attached :cover
  has_rich_text :description

  scope :containing, ->(query) { content_containing(query).or(name_containing(query)) }
  scope :content_containing, ->(query) { joins(:rich_text_description).merge(ActionText::RichText.with_body_containing(query)) }
  scope :name_containing, ->(query) { where("entries.name ILIKE ?", "%#{query}%") }

  private

  def description_not_default
    return if description.nil?
    return if description.body.to_plain_text.squish !=
      ActionText::Content.new(DEFAULT_DESCRIPTION).to_plain_text.squish

    errors.add(:description, :default)
  end
end
