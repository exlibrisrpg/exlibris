class Search
  include ActiveModel::Model

  attr_accessor :query

  validates :query, presence: true

  def entries
    return Entry.none unless valid?

    Entry.by_name.with_includes.containing(query)
  end

  def random_entries
    entries.reorder(Arel.sql("RANDOM()"))
  end

  def random_entry
    random_entries.first
  end

  def tags
    return Tag.none unless valid?

    Tag.by_name.containing(query)
  end
end
