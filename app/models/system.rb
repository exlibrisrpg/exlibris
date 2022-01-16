class System < ApplicationRecord
  extend FriendlyId

  validates :name, presence: true

  friendly_id :name, use: :slugged
end
