class Tag < ApplicationRecord
  has_and_belongs_to_many :entries

  validates :name, presence: true

  scope :containing, ->(query) { where("tags.name ILIKE ?", "%#{query}%") }
end
