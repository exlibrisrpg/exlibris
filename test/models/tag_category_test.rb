require "test_helper"

class TagCategoryTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:tags)
  end

  context "validations" do
    should validate_presence_of(:name)
  end
end
