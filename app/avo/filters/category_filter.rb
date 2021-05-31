class CategoryFilter < Avo::Filters::SelectFilter
  self.name = "Category filter"

  def apply(request, query, value)
    query.joins(:tags).where(tags: {id: value})
  end

  def options
    TagCategory.find_by(name: "Categories").tags.each_with_object({}) do |tag, hash|
      hash[tag.id] = tag.name
    end
  end
end
