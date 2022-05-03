class IconComponentPreview < ViewComponent::Preview
  # @!group Types

  def itch
    render(IconComponent.new(type: "itch"))
  end

  def dropbox
    render(IconComponent.new(type: "dropbox"))
  end

  def facebook
    render(IconComponent.new(type: "facebook"))
  end

  def google
    render(IconComponent.new(type: "google"))
  end

  def morkborg
    render(IconComponent.new(type: "morkborg"))
  end

  def link
    render(IconComponent.new(type: "link"))
  end

  def search
    render(IconComponent.new(type: "search"))
  end

  # @!endgroup
end
