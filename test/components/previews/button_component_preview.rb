class ButtonComponentPreview < ViewComponent::Preview
  # @param label
  # @param type select [primary, secondary, accent]
  def default(label: "Button Label", type: :primary)
    render(ButtonComponent.new(label: label, path: "#", type: type))
  end
end
