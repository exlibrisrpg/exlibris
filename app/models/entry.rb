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

  validates :name, presence: true
  validates :description, presence: true
  validate :description_not_default

  has_rich_text :description

  private

  def description_not_default
    return if description.nil?
    return if description.body.to_plain_text.squish !=
      ActionText::Content.new(DEFAULT_DESCRIPTION).to_plain_text.squish

    errors.add(:description, :default)
  end
end
