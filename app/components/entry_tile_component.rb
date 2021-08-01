class EntryTileComponent < ViewComponent::Base
  attr_reader :entry

  with_collection_parameter :entry

  def initialize(entry:)
    @entry = entry
  end

  def category_tags
    @category_tags ||= entry.tags.select(&:category?)
  end
end
