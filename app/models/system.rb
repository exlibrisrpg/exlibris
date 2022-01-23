class System < ApplicationRecord
  extend FriendlyId

  has_many :curation_roles, dependent: :destroy
  has_many :curators, through: :curation_roles, source: :user
  has_many :entries

  validates :name, presence: true

  friendly_id :name, use: :slugged
end
