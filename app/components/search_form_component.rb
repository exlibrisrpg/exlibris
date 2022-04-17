class SearchFormComponent < ViewComponent::Base
  attr_reader :search, :opened

  def initialize(search:, opened: false)
    @search = search
    @opened = opened
  end
end
