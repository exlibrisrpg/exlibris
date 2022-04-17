require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  test "show all entries" do
    visit entries_path

    assert_text current_system.entries.by_name.first.name
  end

  test "infinite scroll all entries" do
    Entry.create(
      20.times.map do |i|
        {
          name: "Example Entry #{i}",
          description: "Placeholder description",
          system: current_system
        }
      end
    )

    visit entries_path

    assert_scrolling_loads_more_entries
  end

  test "view an entry" do
    entry = current_system.entries.last

    visit entry_path(entry)

    assert_text entry.name
  end
end
