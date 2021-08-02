class EntryTileComponent < ViewComponent::Base
  attr_reader :entry

  with_collection_parameter :entry

  def initialize(entry:)
    @entry = entry
  end

  def category_tags
    @category_tags ||= entry.tags.select(&:category?)
  end

  def cover_url
    url_for entry.cover.variant(resize_to_limit: [450, 450])
  end
end
