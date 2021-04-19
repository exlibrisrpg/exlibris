class Link < ApplicationRecord
  belongs_to :entry

  validates :address, presence: true
end
