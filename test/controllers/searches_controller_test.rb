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
  end
end
