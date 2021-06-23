class Dashboard
  def categories
    Tag.includes(:tag_category).where(tag_categories: {name: "Categories"})
  end

  def recently_created_entries
    Entry.order(created_at: :desc).limit(10)
  end
end
