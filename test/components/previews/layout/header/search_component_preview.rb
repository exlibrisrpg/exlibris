# @display body_class "bg-yellow"
class Layout::Header::SearchComponentPreview < ViewComponent::Preview
  # A search box which will expand to fill any available space. This search box
  # cannot currently show, add or remove filter tags - unlike the search box on
  # the search page.
  #
  # `data-turbo-permanent` is set on this component which will allow it to
  # retain the current search query as a user navigates around the site.
  #
  # @param query
  def default(query: "")
    render(Layout::Header::SearchComponent.new(search: Search.new(query: query)))
  end
end
