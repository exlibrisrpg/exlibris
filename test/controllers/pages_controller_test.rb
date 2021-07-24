require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  context "GET about" do
    should "respond ok" do
      get about_path

      assert_response :ok
    end
  end
end
