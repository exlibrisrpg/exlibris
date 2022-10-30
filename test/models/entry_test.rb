require "test_helper"

class EntryTest < ActiveSupport::TestCase
  system = System.create(name: "Test")

  context "associations" do
    subject { Entry.new(system: system) }

    should belong_to(:system).optional(false)
    should have_and_belong_to_many(:tags).conditions(system: system)
    should have_many(:links).dependent(:destroy)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:description)
    should validate_presence_of(:system)
    should_not allow_value(Entry::DEFAULT_DESCRIPTION).for(:description)
  end

  context "attributes" do
    should have_one_attached(:cover)
    should have_rich_text(:description)
  end

  should accept_nested_attributes_for(:links).allow_destroy(true)

  context ".category_tags" do
    should "return tags under the 'Categories' Tag Category for the same system" do
      assert_includes tags(:mausritter_rules).entries.first.category_tags, tags(:mausritter_rules)
      assert_includes tags(:mork_borg_rules).entries.first.category_tags, tags(:mork_borg_rules)
    end
  end

  context ".containing" do
    should "match on name and description" do
      results = Entry.containing("eat or feat")

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
