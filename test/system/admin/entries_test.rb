require "application_system_test_case"

class Admin::EntriesTest < ApplicationSystemTestCase
  test "show all entries" do
    sign_in

    visit admin_entries_path

    assert_text entries(:eat_prey_kill).name
  end

  test "create new entry" do
    sign_in

    visit new_admin_entry_path

    fill_in Entry.human_attribute_name(:name), with: "The Black Salt"
    attach_file Entry.human_attribute_name(:cover), file_fixture("eatpreykill.png")
    fill_in_rich_text_area Entry.human_attribute_name(:description), with: <<~HTML
      <div>
        <strong>Concept:</strong> “Springing from despair itself, the Black Winds echoed through Tombs, Palaces and places deep beneath the earth.”
        <strong><br>Content:</strong> Potentially lethal weather event
        <strong><br>Writing:</strong> Delivers necessary context and instructions
        <strong><br>Art/design:</strong> Text heavy with subtle but effective graphics
        <strong><br>Usability:</strong> Two tables filled with mortification
      </div>
    HTML
    check tags(:mork_borg_cult).name
    click_on I18n.t("helpers.submit.entry.create")

    assert_text "The Black Salt"
    assert_text tags(:mork_borg_cult).name
    assert_selector "img[src$='eatpreykill.png']"
  end

  test "validate attempts to create" do
    sign_in

    visit new_admin_entry_path

    fill_in Entry.human_attribute_name(:name), with: ""
    click_on I18n.t("helpers.submit.entry.create")

    assert_text "#{Entry.human_attribute_name(:name)} #{Entry.new.errors.generate_message(:name, :blank)}"
  end

  test "view an entry" do
    sign_in

    entry = entries(:eat_prey_kill)

    visit admin_entry_path(entry)

    assert_text entry.name
  end

  test "edit an entry" do
    sign_in

    entry = entries(:eat_prey_kill)

    visit edit_admin_entry_path(entry)
    fill_in Entry.human_attribute_name(:name), with: "Eat, Prey, Kill!!!"
    click_on I18n.t("helpers.submit.entry.update")

    assert_text "Eat, Prey, Kill!!!"
  end

  test "validate attempts to edit" do
    sign_in

    entry = entries(:eat_prey_kill)

    visit edit_admin_entry_path(entry)
    fill_in Entry.human_attribute_name(:name), with: ""
    click_on I18n.t("helpers.submit.entry.update")

    assert_text "#{Entry.human_attribute_name(:name)} #{Entry.new.errors.generate_message(:name, :blank)}"
  end

  test "delete an entry" do
    sign_in

    entry = entries(:eat_prey_kill)

    visit admin_entry_path(entry)
    accept_confirm do
      click_on I18n.t("admin.entries.entry.delete_button")
    end

    assert_no_text entry.name
  end
end
