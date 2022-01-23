require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  context "GET show" do
    should "respond ok" do
      get search_path

      assert_response :ok
    end

    should "pass a search object if query provided" do
      get search_path, params: {query: "cult"}

      assert_equal assigns[:search].query, "cult"
    end

    should "pass a search object if tags provided" do
      get search_path, params: {tags: [tags(:rules).slug]}

      assert_equal assigns[:search].filter_tags, [tags(:rules)]
    end

    should "pass a search object if comma separated tags provided" do
      get search_path, params: {tags: "#{tags(:rules).slug},#{tags(:johan_nohr).slug}"}

      assert_empty assigns[:search].filter_tags.to_a.difference([tags(:rules), tags(:johan_nohr)])
    end

    context "with random param" do
      should "redirect to entry from query" do
        get search_path, params: {query: "eat", random: true}

        assert_redirected_to entries(:eat_prey_kill)
      end

      should "redirect to entry from tag list" do
        get search_path, params: {tags: "#{tags(:rules).slug},#{tags(:johnny_carhat).slug}", random: true}

        assert_redirected_to entries(:unheroic_feats)
      end

      should "respond ok without a query" do
        get search_path, params: {query: "", tags: "", random: true}

        assert_response :redirect
      end
    end
  end
end
