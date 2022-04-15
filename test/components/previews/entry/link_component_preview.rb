class Entry::LinkComponentPreview < ViewComponent::Preview
  # @param url select [[Mörk Borg, 'https://www.morkborg.com/something'],
  #                    [Dropbox, 'https://www.dropbox.com/something'],
  #                    [Facebook, 'https://www.facebook.com/something'],
  #                    [Google, 'https://www.google.com/something'],
  #                    [Itch, 'https://dothorse.itch.io/something'],
  #                    [Website, 'https://www.emailaddress.horse/something']]
  def default(url: "https://www.morkborg.com/something")
    render(Entry::LinkComponent.new(url: url))
  end
end
