class TagCategory < ApplicationRecord
  has_many :tags

  validates :name, presence: true

  default_scope { order(name: :asc) }
end
