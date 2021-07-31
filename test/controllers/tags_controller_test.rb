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

    should "redirect if slug has changed" do
      tag = tags(:mork_borg_cult).tap(&:save)
      original_slug = tag.slug
      tag.update(name: "new name for new slug")

      get tag_path(id: original_slug)

      assert_redirected_to tag_path(id: tag.slug)
    end
  end
end
