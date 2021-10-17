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

    context "with random param" do
      should "redirect to entry" do
        get search_path, params: {query: "eat", random: true}

        assert_redirected_to entries(:eat_prey_kill)
      end
    end
  end
end
