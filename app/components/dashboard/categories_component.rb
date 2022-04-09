class Dashboard::CategoriesComponent < ViewComponent::Base
  attr_reader :categories

  def initialize(categories:)
    @categories = categories
  end
end
