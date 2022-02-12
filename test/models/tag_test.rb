require "test_helper"

class TagTest < ActiveSupport::TestCase
  context "associations" do
    should have_and_belong_to_many(:entries).order('LOWER("entries"."name") asc')
    should belong_to :tag_category
    should belong_to(:system).optional(true)
  end

  context "validations" do
    should validate_presence_of :name
    should validate_presence_of :tag_category

    context "with tag categories that requires short description" do
      subject { Tag.new(tag_category: tag_categories(:categories)) }

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
end
