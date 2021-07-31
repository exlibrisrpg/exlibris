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

    should "redirect if slug has changed" do
      entry = entries(:eat_prey_kill).tap(&:save)
      original_slug = entry.slug
      entry.update(name: "new name for new slug")

      get entry_path(id: original_slug)

      assert_redirected_to entry_path(id: entry.slug)
    end
  end
end
