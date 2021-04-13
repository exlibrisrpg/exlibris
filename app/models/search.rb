class Search
  include ActiveModel::Model

  attr_accessor :query

  validates :query, presence: true

  def entries
    return [] unless valid?

    Entry.with_includes.containing(query)
  end

  def tags
    return [] unless valid?

    Tag.containing(query)
  end
end
