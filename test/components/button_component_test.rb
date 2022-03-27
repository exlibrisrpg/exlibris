require "test_helper"

class ButtonComponentTest < ViewComponent::TestCase
  should "use correct class for primary" do
    render_inline(ButtonComponent.new(label: "Button", path: "#", type: :primary))

    assert_selector("a.tw-button")
  end

  should "use correct class for secondary" do
    render_inline(ButtonComponent.new(label: "Button", path: "#", type: :secondary))

    assert_selector("a.tw-button.tw-button-secondary")
  end

  should "use correct class for accent" do
    render_inline(ButtonComponent.new(label: "Button", path: "#", type: :accent))

    assert_selector("a.tw-button.tw-button-accent")
  end
end
