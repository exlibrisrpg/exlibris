require "test_helper"

class EntryComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    render_inline(
      EntryComponent.new(entry: entries(:eat_prey_kill))
    ).to_html
  end
end
