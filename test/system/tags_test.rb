require "application_system_test_case"

class TagsTest < ApplicationSystemTestCase
  test "show all tags" do
    visit tags_path

    assert_text tags(:mork_borg_cult).name
  end

  test "create new tag" do
    visit new_tag_path

    fill_in Tag.human_attribute_name(:name), with: "Karl Druid"
    click_on I18n.t("helpers.submit.tag.create")

    assert_text "Karl Druid"
  end

  test "validate attempts to create" do
    visit new_tag_path

    fill_in Tag.human_attribute_name(:name), with: ""
    click_on I18n.t("helpers.submit.tag.create")

    assert_text "#{Tag.human_attribute_name(:name)} #{Tag.new.errors.generate_message(:name, :blank)}"
  end

  test "view a tag" do
    tag = tags(:mork_borg_cult)

    visit tag_path(tag)

    assert_text tag.name
  end

  test "edit a tag" do
    tag = tags(:mork_borg_cult)

    visit edit_tag_path(tag)
    fill_in Entry.human_attribute_name(:name), with: "Mörk Borg Cult!!!"
    click_on I18n.t("helpers.submit.tag.update")

    assert_text "Mörk Borg Cult!!!"
  end

  test "validate attempts to edit" do
    tag = tags(:mork_borg_cult)

    visit edit_tag_path(tag)
    fill_in Entry.human_attribute_name(:name), with: ""
    click_on I18n.t("helpers.submit.tag.update")

    assert_text "#{Entry.human_attribute_name(:name)} #{Entry.new.errors.generate_message(:name, :blank)}"
  end

  test "delete a tag" do
    tag = tags(:mork_borg_cult)

    visit tag_path(tag)
    accept_confirm do
      click_on I18n.t("tags.show.delete_button")
    end

    assert_no_text tag.name
  end
end
