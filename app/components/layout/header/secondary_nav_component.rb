class Layout::Header::SecondaryNavComponent < ViewComponent::Base
  def initialize(links:)
    @links = links
  end
end
