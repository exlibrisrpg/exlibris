class TagCategory < ApplicationRecord
  has_many :tags, proc { by_name }
  belongs_to :system, optional: true

  validates :name, presence: true

  default_scope { order(name: :asc) }
end
