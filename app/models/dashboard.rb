class Dashboard
  def categories
    Tag.includes(:tag_category).where(tag_categories: {name: "Categories"}).reorder(:order)
  end

  def recently_created_entries
    Entry.order(created_at: :desc).limit(10)
  end
end
