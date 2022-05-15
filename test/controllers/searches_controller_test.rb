require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  context "GET show" do
    should "respond ok" do
      get search_url(subdomain: "morkborg")

      assert_response :ok
    end

    should "pass current system to search object" do
      get search_url(subdomain: "morkborg"), params: {query: "cult"}

      assert_equal assigns[:search].system, systems(:mork_borg)
    end

    should "pass a search object if query provided" do
      get search_url(subdomain: "morkborg"), params: {query: "cult"}

      assert_equal assigns[:search].query, "cult"
    end

    should "pass a search object if tags provided" do
      get search_url(subdomain: "morkborg"), params: {tags: [tags(:mork_borg_rules).slug]}

      assert_equal assigns[:search].filter_tags, [tags(:mork_borg_rules)]
    end

    should "pass a search object if comma separated tags provided" do
      get search_url(subdomain: "morkborg"), params: {tags: "#{tags(:mork_borg_rules).slug},#{tags(:johan_nohr).slug}"}

      assert_empty assigns[:search].filter_tags.to_a.difference([tags(:mork_borg_rules), tags(:johan_nohr)])
    end

    context "with random param" do
      should "redirect to entry from query" do
        get search_url(subdomain: "morkborg"), params: {query: "eat", random: true}

        assert_redirected_to entry_url(entries(:eat_prey_kill), subdomain: "morkborg")
      end

      should "redirect to entry from tag list" do
        get search_url(subdomain: "morkborg"), params: {tags: "#{tags(:mork_borg_rules).slug},#{tags(:johnny_carhat).slug}", random: true}

        assert_redirected_to entry_url(entries(:unheroic_feats), subdomain: "morkborg")
      end

      should "redirect to any entry without a query" do
        get search_url(subdomain: "morkborg"), params: {query: "", tags: "", random: true}

        assert_redirected_to(/\/entries\/\w+/)
      end
    end
  end
end
