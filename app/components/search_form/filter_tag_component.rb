class SearchForm::FilterTagComponent < ViewComponent::Base
  with_collection_parameter :tag

  attr_reader :selected

  def initialize(tag:, selected: false)
    @tag = tag
    @selected = selected
  end

  def id
    dom_id @tag
  end

  def name
    @tag.name
  end

  def slug
    @tag.slug
  end
end
