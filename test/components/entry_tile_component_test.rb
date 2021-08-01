require "test_helper"

class EntryTileComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    render_inline(
      EntryTileComponent.new(entry: entries(:eat_prey_kill))
    ).to_html
  end
end
