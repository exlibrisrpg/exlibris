class User < ApplicationRecord
  include Clearance::User

  enum role: {
    admin: "admin",
    curator: "curator"
  }
end
