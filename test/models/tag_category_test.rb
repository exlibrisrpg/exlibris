require "test_helper"

class TagCategoryTest < ActiveSupport::TestCase
  system = System.create(name: "Test")

  context "associations" do
    subject { TagCategory.new(system: system) }

    should have_many(:tags).conditions(system: system).order('LOWER("tags"."name") asc')
    should belong_to(:system).optional(true)
  end

  context "validations" do
    should validate_presence_of(:name)
  end
end
