class Entry::LinkComponentPreview < ViewComponent::Preview
  # @!group Types

  def mork_borg(url: "https://www.morkborg.com/something")
    render(Entry::LinkComponent.new(url: url))
  end

  def dropbox(url: "https://www.dropbox.com/something")
    render(Entry::LinkComponent.new(url: url))
  end

  def facebook(url: "https://www.facebook.com/something")
    render(Entry::LinkComponent.new(url: url))
  end

  def google(url: "https://www.google.com/something")
    render(Entry::LinkComponent.new(url: url))
  end

  def itch(url: "https://dothorse.itch.io/something")
    render(Entry::LinkComponent.new(url: url))
  end

  def website(url: "https://emailaddress.horse/something")
    render(Entry::LinkComponent.new(url: url))
  end

  # @!endgroup
end
