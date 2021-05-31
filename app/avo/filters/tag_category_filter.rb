class TagCategoryFilter < Avo::Filters::SelectFilter
  self.name = "Tag category filter"

  def apply(request, query, value)
    query.where(tag_category: value)
  end

  def options
    TagCategory.all.each_with_object({}) do |category, hash|
      hash[category.id] = category.name
    end
  end
end
