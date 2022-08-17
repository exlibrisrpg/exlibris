require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  context "GET show" do
    should "respond ok" do
      get dashboard_url(subdomain: "morkborg")

      assert_response :ok
    end
  end
end
