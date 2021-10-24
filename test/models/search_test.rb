require "test_helper"

class SearchTest < ActiveSupport::TestCase
  context "#entries" do
    should "return empty array with no query" do
      assert_equal Search.new.entries, Entry.none
    end

    context "with a query" do
      should "return entry query" do
        assert_equal Search.new(query: "cult").entries, Entry.by_name.containing("cult")
      end

      should "ignore punctuation when matching" do
        entry = Entry.create(name: "Example", description: "Match: a colon")
        assert_includes Search.new(query: "matching a colon").entries, entry
      end

      should "unaccent special characters in entry description when matching" do
        entry = Entry.create(name: "Example", description: "A Mörk Borg entry")
        assert_includes Search.new(query: "mörk borg").entries, entry
      end

      should "unaccent special characters in entry name when matching" do
        entry = Entry.create(name: "Mörk Borg Entry", description: "An entry")
        assert_includes Search.new(query: "mörk borg").entries, entry
      end
    end

    context "with filter_tag_slugs" do
      should "return entry query" do
        rules_tag = tags(:rules)
        results = Search.new(filter_tag_slugs: [rules_tag.slug]).entries
        assert_empty results.to_a.difference(tags(:rules).entries)
      end

      should "return entries with all tags" do
        slugs = [tags(:rules), tags(:johnny_carhat)].map(&:slug)
        results = Search.new(filter_tag_slugs: slugs).entries
        assert_empty results.to_a.difference([entries(:unheroic_feats)])
      end
    end
  end

  context "#random_entries" do
    should "order entries in a random order with SQL" do
      assert_includes Search.new(query: "query").random_entries.to_sql, "ORDER BY RANDOM()"
    end
  end

  context "#tags" do
    should "return empty array with no query" do
      assert_equal Search.new(query: nil).tags, Tag.none
    end

    should "return tag query with a query" do
      assert_equal Search.new(query: "cult").tags, Tag.by_name.containing("cult")
    end

    should "unaccent special characters in tag name when matching" do
      assert_includes Search.new(query: "mörk borg").tags, tags(:mork_borg_cult)
    end
  end
end
