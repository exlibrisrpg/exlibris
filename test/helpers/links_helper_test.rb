require "test_helper"

class LinksHelperTest < ActionView::TestCase
  test "should shorten itch links" do
    link = links(:eat_prey_kill_itch)

    assert_equal "itch.io", link_name(link)
  end

  test "should return domain for other links" do
    link = Link.new(address: "https://morkborg.com/content/")

    assert_equal "morkborg.com", link_name(link)
  end
end
