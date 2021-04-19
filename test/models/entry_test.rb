require "test_helper"

class EntryTest < ActiveSupport::TestCase
  context "associations" do
    should have_and_belong_to_many(:tags)
    should have_many(:links).dependent(:destroy)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:description)
    should_not allow_value(Entry::DEFAULT_DESCRIPTION).for(:description)
  end

  context "attributes" do
    should have_one_attached(:cover)
    should have_rich_text(:description)
  end

  should accept_nested_attributes_for(:links).allow_destroy(true)

  context ".containing" do
    should "match on name and description" do
      results = Entry.containing("eat")

      assert_includes results, entries(:eat_prey_kill)
      assert_includes results, entries(:unheroic_feats)
    end
  end

  context ".content_containing" do
    should "match growl to eat_prey_kill description" do
      results = Entry.content_containing("growl")

      assert_includes results, entries(:eat_prey_kill)
    end
  end

  context ".name_containing" do
    should "match prey to eat_prey_kill name" do
      results = Entry.name_containing("prey")

      assert_includes results, entries(:eat_prey_kill)
    end
  end
end
