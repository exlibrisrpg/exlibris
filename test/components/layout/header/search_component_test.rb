require "test_helper"

class Layout::Header::SearchComponentTest < ViewComponent::TestCase
  should "present a valid search form" do
    render_inline(Layout::Header::SearchComponent.new(search: Search.new))

    assert_all_of_selectors(
      "form[action='/search'][method='get']",
      "input[name='query']"
    )
  end

  should "fill input with existing query" do
    search = Search.new(query: "test query")

    render_inline(Layout::Header::SearchComponent.new(search: search))

    assert_selector("input[name='query'][value='test query']")
  end
end
