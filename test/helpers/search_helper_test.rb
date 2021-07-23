require "test_helper"

class SearchHelperTest < ActionView::TestCase
  test "should highlight words separately" do
    assert_equal "My <mark>Mörk</mark> <mark>Borg</mark> result", search_highlight("My Mörk Borg result", ["mörk", "borg"])
  end

  test "should ignore case when highlighting" do
    assert_equal "My <mark>Mörk</mark> Borg result", search_highlight("My Mörk Borg result", ["MöRk"])
  end

  test "should ignore lack of diacritics when highlighting" do
    assert_equal "My <mark>Mörk</mark> Borg result", search_highlight("My Mörk Borg result", ["mork"])
  end

  test "should ignore presence of diacritics when highlighting" do
    assert_equal "My <mark>Mork</mark> Borg result", search_highlight("My Mork Borg result", ["mörk"])
  end

  test "should ignore html tags when highlighting" do
    assert_equal "A <strong>very</strong> <mark>strong</mark> concept", search_highlight("A <strong>very</strong> strong concept", ["strong"])
  end
end
