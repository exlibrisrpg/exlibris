require "test_helper"

class Admin::TagsControllerTest < ActionDispatch::IntegrationTest
  context "GET index" do
    should "require login" do
      get admin_tags_path

      assert_requires_authentication
    end

    should "respond ok" do
      sign_in

      get admin_tags_path

      assert_response :ok
    end
  end

  context "GET new" do
    should "require login" do
      get new_admin_tag_path

      assert_requires_authentication
    end

    should "respond ok" do
      sign_in

      get new_admin_tag_path

      assert_response :ok
    end
  end

  context "POST create" do
    should "require login" do
      post admin_tags_path

      assert_requires_authentication
    end

    should "render new with invalid params" do
      sign_in

      invalid_params = {tag: {name: ""}}

      post admin_tags_path, params: invalid_params

      assert_template "tags/new"
    end

    should "redirect to created tag with valid params" do
      sign_in

      valid_params = {tag: {name: "Karl Druid", tag_category_id: tag_categories(:creators).id}}

      assert_changes -> { Tag.count } do
        post admin_tags_path, params: valid_params
      end

      assert_redirected_to admin_tag_path(Tag.last)
    end
  end

  context "GET show" do
    should "require login" do
      get admin_tag_path(tags(:mork_borg_cult))

      assert_requires_authentication
    end

    should "respond ok" do
      sign_in

      get admin_tag_path(tags(:mork_borg_cult))

      assert_response :ok
    end
  end

  context "GET edit" do
    should "require login" do
      get edit_admin_tag_path(tags(:mork_borg_cult))

      assert_requires_authentication
    end

    should "respond ok" do
      sign_in

      tag = tags(:mork_borg_cult)

      get edit_admin_tag_path(tag)

      assert_response :ok
    end
  end

  context "PATCH update" do
    should "require login" do
      patch admin_tag_path(tags(:mork_borg_cult))

      assert_requires_authentication
    end

    should "render edit with invalid params" do
      sign_in

      tag = tags(:mork_borg_cult)
      invalid_params = {tag: {name: ""}}

      patch admin_tag_path(tag), params: invalid_params

      assert_template "tags/edit"
    end

    should "redirect to updated tag with valid params" do
      sign_in

      tag = tags(:mork_borg_cult)
      valid_params = {tag: {name: "Mörk Borg Cult!!!"}}

      assert_changes -> { tag.reload.name } do
        patch admin_tag_path(tag), params: valid_params
      end

      assert_redirected_to admin_tag_path(tag)
    end
  end

  context "DELETE destroy" do
    should "require login" do
      delete admin_tag_path(tags(:mork_borg_cult))

      assert_requires_authentication
    end

    should "delete the tag" do
      sign_in

      tag = tags(:mork_borg_cult)

      delete admin_tag_path(tag)

      assert_nil Tag.find_by(id: tag.id)
    end
  end
end
