require "test_helper"

class TagTest < ActiveSupport::TestCase
  system = System.create(name: "Test")

  context "associations" do
    subject { Tag.new(system: system) }

    should have_and_belong_to_many(:entries).conditions(system: system).order('LOWER("entries"."name") asc')
    should belong_to(:tag_category).conditions(system: system)
    should belong_to(:system)
  end

  context "validations" do
    should validate_presence_of :name
    should validate_presence_of :tag_category
    should validate_presence_of :system

    context "with tag categories that requires short description" do
      subject { Tag.new(tag_category: tag_categories(:mork_borg_categories)) }

      should validate_presence_of :short_description
    end
  end

  context "attributes" do
    should have_rich_text(:description)
  end

  context ".containing" do
    should "match mork borg cult to cult name" do
      results = Tag.containing("cult")

      assert_includes results, tags(:mork_borg_cult)
    end
  end

  context ".suggestions_for" do
    should "join tag category name with name for label" do
      suggestions = Tag.suggestions_for(systems(:mork_borg))
      suggestion = suggestions.find { |suggestion| suggestion["value"] == tags(:johan_nohr).id }
      assert_equal "Creators > Johan Nohr", suggestion["label"]
    end

    should "sort results by label" do
      suggestions = Tag.suggestions_for(systems(:mork_borg))
      sorted_suggestions = suggestions.sort_by { |suggestion| suggestion["label"] }
      assert_equal sorted_suggestions, suggestions
    end

    should "not include tags for other systems" do
      suggestions = Tag.suggestions_for(systems(:mausritter))
      mork_borg_creator = tags(:johan_nohr)
      assert_nil suggestions.find { |suggestion| suggestion["value"] == mork_borg_creator.id }
    end
  end
end
