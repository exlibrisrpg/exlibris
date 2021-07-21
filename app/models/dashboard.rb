class Dashboard
  def categories
    Tag.categories
  end

  def recently_created_entries
    Entry.order(created_at: :desc).limit(10)
  end
end