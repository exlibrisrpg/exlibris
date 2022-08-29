class System < ApplicationRecord
  extend FriendlyId

  has_many :curation_roles, dependent: :destroy
  has_many :curators, through: :curation_roles, source: :user, inverse_of: :curated_systems
  has_many :entries
  has_many :tags
  has_many :tag_categories

  has_rich_text :footer

  validates :name, presence: true

  scope :live, -> { where(live: true) }

  friendly_id :name, use: :slugged

  def full_name
    "Ex Libris #{name}"
  end
end
