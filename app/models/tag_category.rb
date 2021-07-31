class TagCategory < ApplicationRecord
  has_many :tags, proc { by_name }

  validates :name, presence: true

  default_scope { order(name: :asc) }
end
