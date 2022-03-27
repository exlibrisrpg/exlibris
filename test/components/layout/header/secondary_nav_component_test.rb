require "test_helper"

class Layout::Header::SecondaryNavComponentTest < ViewComponent::TestCase
  should "render provided links" do
    render_inline(Layout::Header::SecondaryNavComponent.new(links: [
      {label: "Link One", path: "/link_one"},
      {label: "Link Two", path: "/link_two"}
    ]))

    assert_selector("a[href='/link_one']", text: "Link One")
    assert_selector("a[href='/link_two']", text: "Link Two")
  end
end
