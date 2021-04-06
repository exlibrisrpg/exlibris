require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  context "GET index" do
    should "respond ok" do
      get entries_path

      assert_response :ok
    end
  end

  context "GET new" do
    should "respond ok" do
      get new_entry_path

      assert_response :ok
    end
  end

  context "POST create" do
    should "render new with invalid params" do
      invalid_params = {entry: {name: ""}}

      post entries_path, params: invalid_params

      assert_template "entries/new"
    end

    should "redirect to created entry with valid params" do
      valid_params = {entry: {name: "The Black Salt", description: "A description"}}

      assert_changes -> { Entry.count } do
        post entries_path, params: valid_params
      end

      assert_redirected_to entry_path(Entry.last)
    end
  end

  context "GET show" do
    should "respond ok" do
      get entry_path(entries(:eat_prey_kill))

      assert_response :ok
    end
  end

  context "GET edit" do
    should "respond ok" do
      entry = entries(:eat_prey_kill)

      get edit_entry_path(entry)

      assert_response :ok
    end
  end

  context "PATCH update" do
    should "render edit with invalid params" do
      entry = entries(:eat_prey_kill)
      invalid_params = {entry: {name: ""}}

      patch entry_path(entry), params: invalid_params

      assert_template "entries/edit"
    end

    should "redirect to updated entry with valid params" do
      entry = entries(:eat_prey_kill)
      valid_params = {entry: {name: "Eat, Prey, Kill!!!"}}

      assert_changes -> { entry.reload.name } do
        patch entry_path(entry), params: valid_params
      end

      assert_redirected_to entry_path(entry)
    end
  end

  context "DELETE destroy" do
    should "delete the entry" do
      entry = entries(:eat_prey_kill)

      delete entry_path(entry)

      assert_nil Entry.find_by(id: entry.id)
    end
  end
end
