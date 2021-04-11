require "test_helper"

class EntryTest < ActiveSupport::TestCase
  context "associations" do
    should have_and_belong_to_many :tags
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:description)
    should_not allow_value(Entry::DEFAULT_DESCRIPTION).for(:description)
  end

  context "attributes" do
    should have_rich_text(:description)
  end
end
