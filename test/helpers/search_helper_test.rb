require "test_helper"

class SearchHelperTest < ActionView::TestCase
  test "should ignore diacritics when highlighting" do
    assert_equal "My <mark>Mörk</mark> <mark>Borg</mark> result", search_highlight("My Mörk Borg result", ["mork", "borg"])
  end
end
