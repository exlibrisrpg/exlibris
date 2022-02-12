class TagCategory < ApplicationRecord
  has_many :tags, ->(tag_category) { by_name.where(system: tag_category.system) }
  belongs_to :system, optional: true

  validates :name, presence: true

  default_scope { order(name: :asc) }
end
