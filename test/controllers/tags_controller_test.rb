require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  context "GET index" do
    should "respond ok" do
      get tags_path

      assert_response :ok
    end
  end

  context "GET show" do
    should "respond ok" do
      get tag_path(tags(:mork_borg_cult))

      assert_response :ok
    end
  end
end
