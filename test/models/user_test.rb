require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:curation_roles).dependent(:destroy)
    should have_many(:curated_systems)
  end

  context "attributes" do
    should define_enum_for(:role).with_values({
      admin: "admin",
      curator: "curator"
    }).backed_by_column_of_type(:enum)
  end
end
