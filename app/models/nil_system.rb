class NilSystem
  def entries
    Entry.all
  end

  def tag_categories
    TagCategory.none
  end
end
