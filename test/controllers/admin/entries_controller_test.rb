require "test_helper"

class Admin::EntriesControllerTest < ActionDispatch::IntegrationTest
  context "GET index" do
    should "require login" do
      get admin_entries_path

      assert_requires_authentication
    end

    should "respond ok" do
      sign_in

      get admin_entries_path

      assert_response :ok
    end
  end

  context "GET new" do
    should "require login" do
      get new_admin_entry_path

      assert_requires_authentication
    end

    should "respond ok" do
      sign_in

      get new_admin_entry_path

      assert_response :ok
    end
  end

  context "POST create" do
    should "require login" do
      post admin_entries_path

      assert_requires_authentication
    end

    should "render new with invalid params" do
      sign_in

      invalid_params = {entry: {name: ""}}

      post admin_entries_path, params: invalid_params

      assert_template "entries/new"
    end

    should "redirect to created entry with valid params" do
      sign_in

      valid_params = {entry: {
        name: "The Black Salt",
        description: "A description",
        cover: fixture_file_upload("eatpreykill.png", "image/png"),
        tag_ids: [tags(:rules).id]
      }}

      assert_changes -> { Entry.count } do
        assert_changes -> { tags(:rules).entries.count } do
          assert_changes -> { ActiveStorage::Attachment.count } do
            post admin_entries_path, params: valid_params
          end
        end
      end

      assert_redirected_to admin_entry_path(Entry.last)
    end
  end

  context "GET show" do
    should "require login" do
      get admin_entry_path(entries(:eat_prey_kill))

      assert_requires_authentication
    end

    should "respond ok" do
      sign_in

      get admin_entry_path(entries(:eat_prey_kill))

      assert_response :ok
    end
  end

  context "GET edit" do
    should "require login" do
      get edit_admin_entry_path(entries(:eat_prey_kill))

      assert_requires_authentication
    end

    should "respond ok" do
      sign_in

      entry = entries(:eat_prey_kill)

      get edit_admin_entry_path(entry)

      assert_response :ok
    end
  end

  context "PATCH update" do
    should "require login" do
      patch admin_entry_path(entries(:eat_prey_kill))

      assert_requires_authentication
    end

    should "render edit with invalid params" do
      sign_in

      entry = entries(:eat_prey_kill)
      invalid_params = {entry: {name: ""}}

      patch admin_entry_path(entry), params: invalid_params

      assert_template "entries/edit"
    end

    should "redirect to updated entry with valid params" do
      sign_in

      entry = entries(:eat_prey_kill)
      valid_params = {entry: {name: "Eat, Prey, Kill!!!"}}

      assert_changes -> { entry.reload.name } do
        patch admin_entry_path(entry), params: valid_params
      end

      assert_redirected_to admin_entry_path(entry)
    end
  end

  context "DELETE destroy" do
    should "require login" do
      delete admin_entry_path(entries(:eat_prey_kill))

      assert_requires_authentication
    end

    should "delete the entry" do
      sign_in

      entry = entries(:eat_prey_kill)

      delete admin_entry_path(entry)

      assert_nil Entry.find_by(id: entry.id)
    end
  end
end
