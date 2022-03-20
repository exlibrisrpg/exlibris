class Layout::Header::SearchComponent < ViewComponent::Base
  def initialize(search:)
    @search = search
  end

  def placeholder
    Search.model_name.human
  end

  def search_icon
    helpers.icon_tag :search
  end
end
