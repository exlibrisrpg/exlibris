require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  context "GET index" do
    should "respond ok" do
      get entries_path

      assert_response :ok
    end

    should "assign page with all Mörk Borg entries" do
      get entries_path

      assert_equal systems(:mork_borg).entries.by_name.with_includes, assigns[:page].recordset.records
    end

    context "with a recognised subdomain" do
      should "respond ok" do
        get entries_url(subdomain: "mausritter")

        assert_response :ok
      end

      should "assign page with entries for system" do
        get entries_url(subdomain: "mausritter")

        assert_equal systems(:mausritter).entries.by_name.with_includes, assigns[:page].recordset.records
      end
    end

    context "with an unrecognised subdomain" do
      should "raise record not found" do
        assert_raises ActiveRecord::RecordNotFound do
          get entries_url(subdomain: "johnshorsegame")
        end
      end
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

    context "with the correct subdomain" do
      should "respond ok" do
        get entry_url(entries(:eat_prey_kill), subdomain: "morkborg")

        assert_response :ok
      end
    end

    context "with an incorrect subdomain" do
      should "raise record not found" do
        assert_raises ActiveRecord::RecordNotFound do
          get entry_url(entries(:eat_prey_kill), subdomain: "mausritter")
        end
      end
    end

    context "with an unrecognised subdomain" do
      should "raise record not found" do
        assert_raises ActiveRecord::RecordNotFound do
          get entry_url(entries(:eat_prey_kill), subdomain: "johnshorsegame")
        end
      end
    end
  end
end
