require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  context "GET show" do
    should "respond ok" do
      get root_path

      assert_response :ok
    end
  end
end
