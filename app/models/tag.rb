class Tag < ApplicationRecord
  has_and_belongs_to_many :entries

  validates :name, presence: true
end
