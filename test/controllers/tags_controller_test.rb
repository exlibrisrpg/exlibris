require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  context "GET index" do
    should "respond ok" do
      get tags_path

      assert_response :ok
    end
  end

  context "GET new" do
    should "respond ok" do
      get new_tag_path

      assert_response :ok
    end
  end

  context "POST create" do
    should "render new with invalid params" do
      invalid_params = {tag: {name: ""}}

      post tags_path, params: invalid_params

      assert_template "tags/new"
    end

    should "redirect to created tag with valid params" do
      valid_params = {tag: {name: "Karl Druid"}}

      assert_changes -> { Tag.count } do
        post tags_path, params: valid_params
      end

      assert_redirected_to tag_path(Tag.last)
    end
  end

  context "GET show" do
    should "respond ok" do
      get tag_path(tags(:mork_borg_cult))

      assert_response :ok
    end
  end

  context "GET edit" do
    should "respond ok" do
      tag = tags(:mork_borg_cult)

      get edit_tag_path(tag)

      assert_response :ok
    end
  end

  context "PATCH update" do
    should "render edit with invalid params" do
      tag = tags(:mork_borg_cult)
      invalid_params = {tag: {name: ""}}

      patch tag_path(tag), params: invalid_params

      assert_template "tags/edit"
    end

    should "redirect to updated tag with valid params" do
      tag = tags(:mork_borg_cult)
      valid_params = {tag: {name: "Mörk Borg Cult!!!"}}

      assert_changes -> { tag.reload.name } do
        patch tag_path(tag), params: valid_params
      end

      assert_redirected_to tag_path(tag)
    end
  end

  context "DELETE destroy" do
    should "delete the tag" do
      tag = tags(:mork_borg_cult)

      delete tag_path(tag)

      assert_nil Tag.find_by(id: tag.id)
    end
  end
end
