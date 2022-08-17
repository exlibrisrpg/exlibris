require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  context "GET about" do
    should "respond ok" do
      get about_url(subdomain: "morkborg")

      assert_response :ok
    end
  end
end
