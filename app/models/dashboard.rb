class Dashboard
  include ActiveModel::Model

  attr_accessor :system

  def categories
    Tag.categories(system).includes(:rich_text_description)
  end

  def recently_created_entries
    Entry.where(system: system).includes(cover_attachment: :blob, tags: :tag_category).order(created_at: :desc).limit(10)
  end
end
