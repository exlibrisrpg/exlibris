require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  test "show all entries" do
    visit entries_path

    assert_text entries(:eat_prey_kill).name
  end

  test "infinite scroll all entries" do
    Entry.create(
      20.times.map do |i|
        {
          name: "Example Entry #{i}",
          description: "Placeholder description",
          system: systems(:mork_borg)
        }
      end
    )

    visit entries_path

    assert_scrolling_loads_more_entries
  end

  test "view an entry" do
    entry = entries(:eat_prey_kill)

    visit entry_path(entry)

    assert_text entry.name
  end
end
