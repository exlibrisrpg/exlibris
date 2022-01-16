class CurationRole < ApplicationRecord
  belongs_to :user
  belongs_to :system
end
