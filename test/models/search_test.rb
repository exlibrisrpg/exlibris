require "test_helper"

class SearchTest < ActiveSupport::TestCase
  context "#entries" do
    should "return empty array with no query" do
      assert_equal Search.new(query: nil).entries, []
    end

    should "return entry query with a query" do
      assert_equal Search.new(query: "cult").entries, Entry.containing("cult")
    end
  end

  context "#tags" do
    should "return empty array with no query" do
      assert_equal Search.new(query: nil).tags, []
    end

    should "return tag query with a query" do
      assert_equal Search.new(query: "cult").tags, Tag.containing("cult")
    end
  end
end
