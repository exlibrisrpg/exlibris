require "test_helper"

class SearchTest < ActiveSupport::TestCase
  context "#entries" do
    should "return empty array with no query" do
      assert_equal Search.new(system: systems(:mausritter)).entries, Entry.where(system: systems(:mausritter)).none
    end

    context "with a query" do
      should "return entry query" do
        assert_equal Search.new(system: systems(:morkborg), query: "cult").entries, Entry.where(system: systems(:morkborg)).by_name.containing("cult")
      end

      should "ignore punctuation when matching" do
        entry = Entry.create(name: "Example", description: "Match: a colon", system: systems(:morkborg))
        assert_includes Search.new(system: systems(:morkborg), query: "matching a colon").entries, entry
      end

      should "unaccent special characters in entry description when matching" do
        entry = Entry.create(name: "Example", description: "A Mörk Borg entry", system: systems(:morkborg))
        assert_includes Search.new(system: systems(:morkborg), query: "mörk borg").entries, entry
      end

      should "unaccent special characters in entry name when matching" do
        entry = Entry.create(name: "Mörk Borg Entry", description: "An entry", system: systems(:morkborg))
        assert_includes Search.new(system: systems(:morkborg), query: "mörk borg").entries, entry
      end
    end

    context "with filter_tag_slugs" do
      should "return entry query" do
        rules_tag = tags(:morkborg_rules)
        results = Search.new(system: systems(:morkborg), filter_tag_slugs: [rules_tag.slug]).entries
        assert_empty results.to_a.difference(tags(:morkborg_rules).entries)
      end

      should "return entries with all tags" do
        slugs = [tags(:morkborg_rules), tags(:johnny_carhat)].map(&:slug)
        results = Search.new(system: systems(:morkborg), filter_tag_slugs: slugs).entries
        assert_empty results.to_a.difference([entries(:unheroic_feats)])
      end
    end
  end

  context "#random_entries" do
    should "order entries in a random order with SQL" do
      assert_includes Search.new(system: systems(:morkborg), query: "query").random_entries.to_sql, "ORDER BY RANDOM()"
    end

    context "without query or filter tags" do
      should "randomly select from all entries" do
        assert_equal Entry.where(system: systems(:morkborg)).reorder(Arel.sql("RANDOM()")), Search.new(system: systems(:morkborg)).random_entries
      end
    end
  end

  context "#tags" do
    should "return empty array with no query" do
      assert_equal Search.new(system: systems(:morkborg), query: nil).tags, Tag.where(system: systems(:morkborg)).none
    end

    should "return tag query with a query" do
      assert_equal Search.new(system: systems(:morkborg), query: "cult").tags, Tag.where(system: systems(:morkborg)).by_name.containing("cult").where.not(id: []).limit(10)
    end

    should "exclude filter tags from query" do
      search = Search.new(system: systems(:morkborg), query: "cult", filter_tag_slugs: [tags(:johan_nohr).slug])
      assert_equal search.tags, Tag.where(system: systems(:morkborg)).by_name.containing("cult").where.not(id: [tags(:johan_nohr).id]).limit(10)
    end

    should "unaccent special characters in tag name when matching" do
      assert_includes Search.new(system: systems(:morkborg), query: "mörk borg").tags, tags(:mork_borg_cult)
    end
  end
end
