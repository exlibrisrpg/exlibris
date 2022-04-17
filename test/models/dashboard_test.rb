require "test_helper"

class DashboardTest < ActiveSupport::TestCase
  context "#categories" do
    should "return categories for provided system" do
      assert_equal Tag.categories(systems(:morkborg)).includes(:rich_text_description), Dashboard.new(system: systems(:morkborg)).categories
    end
  end

  context "#categories" do
    should "return recent entries for provided system" do
      assert_equal Entry.where(system: systems(:morkborg)).includes(cover_attachment: :blob, tags: :tag_category).order(created_at: :desc).limit(10), Dashboard.new(system: systems(:morkborg)).recently_created_entries
    end
  end
end
