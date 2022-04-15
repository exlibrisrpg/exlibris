class IconComponentPreview < ViewComponent::Preview
  # @param type select [itch, dropbox, facebook, google, morkborg, link]
  def default(type: "itch")
    render(IconComponent.new(type: type))
  end
end
