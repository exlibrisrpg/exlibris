require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "attributes" do
    should define_enum_for(:role).with_values({
      admin: "admin",
      curator: "curator"
    }).backed_by_column_of_type(:enum)
  end
end
