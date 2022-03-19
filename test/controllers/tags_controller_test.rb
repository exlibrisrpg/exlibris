require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  context "GET index" do
    should "respond ok" do
      get tags_path

      assert_response :ok
    end

    should "filter tag categories by current system" do
      get tags_url(subdomain: systems(:mausritter).slug)

      assert_equal systems(:mausritter).tag_categories.includes(tags: :rich_text_description), assigns[:tag_categories]
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

    should "raise record not found if not in the specified system" do
      assert_raises(ActiveRecord::RecordNotFound) do
        get tag_url(tags(:mork_borg_cult), subdomain: systems(:mausritter).slug)
      end
    end
  end
end
