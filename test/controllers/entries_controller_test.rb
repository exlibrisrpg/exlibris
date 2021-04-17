require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  context "GET index" do
    should "respond ok" do
      get entries_path

      assert_response :ok
    end
  end

  context "GET show" do
    should "respond ok" do
      get entry_path(entries(:eat_prey_kill))

      assert_response :ok
    end
  end
end
