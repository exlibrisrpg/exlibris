require "application_system_test_case"

class TagsTest < ApplicationSystemTestCase
  test "show all tags" do
    visit tags_path

    assert_text tags(:mork_borg_cult).name
  end

  test "view a tag" do
    tag = tags(:mork_borg_cult)

    visit tag_path(tag)

    assert_text tag.name
    assert_text entries(:eat_prey_kill).name
  end
end
