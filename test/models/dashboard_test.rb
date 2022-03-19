require "test_helper"

class DashboardTest < ActiveSupport::TestCase
  context "#categories" do
    should "return categories for provided system" do
      assert_equal Tag.categories(systems(:mork_borg)).includes(:rich_text_description), Dashboard.new(system: systems(:mork_borg)).categories
    end
  end

  context "#categories" do
    should "return recent entries for provided system" do
      assert_equal Entry.where(system: systems(:mork_borg)).includes(cover_attachment: :blob, tags: :tag_category).order(created_at: :desc).limit(10), Dashboard.new(system: systems(:mork_borg)).recently_created_entries
    end
  end
end
