class Dashboard
  def categories
    Tag.categories(Current.system).includes(:rich_text_description)
  end

  def recently_created_entries
    Entry.includes(cover_attachment: :blob, tags: :tag_category).order(created_at: :desc).limit(10)
  end
end
