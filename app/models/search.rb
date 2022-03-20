class Search
  include ActiveModel::Model

  attr_accessor :query, :filter_tag_slugs, :system

  validates :system, presence: true
  validates :query, presence: true, if: -> { filter_tag_slugs.blank? }

  def entries
    entries_scope = Entry.where(system: system)

    return entries_scope.none unless valid?

    entries_scope = entries_scope.by_name.with_includes
    entries_scope = entries_scope.containing(query) unless query.blank?
    entries_scope = entries_scope.with_tags(filter_tags.pluck(:id)) unless filter_tag_slugs.blank?
    entries_scope
  end

  def filter_tags
    Tag.where(slug: filter_tag_slugs)
  end

  def random_entries
    entries_scope = valid? ? entries : Entry.where(system: system)

    entries_scope.reorder(Arel.sql("RANDOM()"))
  end

  def random_entry
    random_entries.first
  end

  def tags
    tags_scope = Tag.where(system: system)

    return tags_scope.none if query.blank?

    tags_scope.by_name.containing(query).where.not(id: filter_tags.pluck(:id)).limit(10)
  end
end
