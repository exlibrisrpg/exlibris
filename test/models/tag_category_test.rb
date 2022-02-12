require "test_helper"

class TagCategoryTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:tags).order('LOWER("tags"."name") asc')
    should belong_to(:system).optional(true)
  end

  context "validations" do
    should validate_presence_of(:name)
  end
end
