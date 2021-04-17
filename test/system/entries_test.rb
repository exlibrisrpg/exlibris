require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  test "show all entries" do
    visit entries_path

    assert_text entries(:eat_prey_kill).name
  end

  test "view an entry" do
    entry = entries(:eat_prey_kill)

    visit entry_path(entry)

    assert_text entry.name
  end
end
