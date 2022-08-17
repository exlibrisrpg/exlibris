require "test_helper"

class SitesControllerTest < ActionDispatch::IntegrationTest
  context "GET show" do
    should "respond ok" do
      get site_url

      assert_response :ok
    end
  end
end
