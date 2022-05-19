class Link < ApplicationRecord
  belongs_to :entry

  acts_as_list scope: :entry

  validates :address, presence: true
end
