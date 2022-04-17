require "application_system_test_case"

class TagsTest < ApplicationSystemTestCase
  test "show all tags" do
    visit tags_path

    assert_text current_system.tags.last.name
  end

  test "view a tag" do
    tag = current_system.tags.last

    visit tag_path(tag)

    assert_text tag.name
  end

  test "infinite scroll tag entries" do
    tag = current_system.tags.last

    tag.entries.create(
      20.times.map do |i|
        {
          name: "Example Entry #{i}",
          description: "Placeholder description",
          system: current_system
        }
      end
    )

    visit tag_path(tag)

    assert_scrolling_loads_more_entries
  end
end
