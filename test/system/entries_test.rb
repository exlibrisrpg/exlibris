require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  test "show all entries" do
    visit entries_path

    assert_text entries(:eat_prey_kill).name
  end

  test "create new entry" do
    visit new_entry_path

    fill_in Entry.human_attribute_name(:name), with: "The Black Salt"
    click_on I18n.t("helpers.submit.entry.create")

    assert_text "The Black Salt"
  end

  test "validate attempts to create" do
    visit new_entry_path

    fill_in Entry.human_attribute_name(:name), with: ""
    click_on I18n.t("helpers.submit.entry.create")

    assert_text "#{Entry.human_attribute_name(:name)} #{Entry.new.errors.generate_message(:name, :blank)}"
  end

  test "view an entry" do
    entry = entries(:eat_prey_kill)

    visit entry_path(entry)

    assert_text entry.name
  end

  test "edit an entry" do
    entry = entries(:eat_prey_kill)

    visit edit_entry_path(entry)
    fill_in Entry.human_attribute_name(:name), with: "Eat, Prey, Kill!!!"
    click_on I18n.t("helpers.submit.entry.update")

    assert_text "Eat, Prey, Kill!!!"
  end

  test "validate attempts to edit" do
    entry = entries(:eat_prey_kill)

    visit edit_entry_path(entry)
    fill_in Entry.human_attribute_name(:name), with: ""
    click_on I18n.t("helpers.submit.entry.update")

    assert_text "#{Entry.human_attribute_name(:name)} #{Entry.new.errors.generate_message(:name, :blank)}"
  end

  test "delete an entry" do
    entry = entries(:eat_prey_kill)

    visit entry_path(entry)
    accept_confirm do
      click_on I18n.t("entries.show.delete_button")
    end

    assert_no_text entry.name
  end
end
