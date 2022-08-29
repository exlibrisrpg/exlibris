class User < ApplicationRecord
  include Clearance::User

  has_many :curation_roles, dependent: :destroy
  has_many :curated_systems, through: :curation_roles, source: :system, inverse_of: :curators

  enum role: {
    admin: "admin",
    curator: "curator"
  }
end
