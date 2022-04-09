class Dashboard::CategoriesComponentPreview < ViewComponent::Preview
  def default
    categories = ["Rules", "Classes", "Gear", "Monsters/NPCs", "Decor", "Adventures", "Etc.", "Tools", "Variants", "Conversions"].map { |name| Tag.new(name: name) }
    render(Dashboard::CategoriesComponent.new(categories: categories))
  end
end
