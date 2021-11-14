class Search
  include ActiveModel::Model

  attr_accessor :query, :filter_tag_slugs

  validates :query, presence: true, if: -> { filter_tag_slugs.blank? }

  def entries
    return Entry.none unless valid?

    entries_scope = Entry.by_name.with_includes
    entries_scope = entries_scope.containing(query) unless query.blank?
    entries_scope = entries_scope.with_tags(filter_tags.pluck(:id)) unless filter_tag_slugs.blank?
    entries_scope
  end

  def filter_tags
    Tag.where(slug: filter_tag_slugs)
  end

  def random_entries
    entries.reorder(Arel.sql("RANDOM()"))
  end

  def random_entry
    random_entries.first
  end

  def tags
    return Tag.none if query.blank?

    Tag.by_name.containing(query).where.not(id: filter_tags.pluck(:id)).limit(10)
  end
end
