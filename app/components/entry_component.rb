class EntryComponent < ViewComponent::Base
  include IconHelper
  include HighlightHelper
  include LinksHelper

  attr_reader :entry, :search_term

  def initialize(entry:, search_term: nil)
    @entry = entry
    @search_term = search_term
  end

  def name
    render HighlighterComponent.new(text: entry.name, phrases: search_term)
  end

  def creator_tags
    @creator_tags ||= entry.tags.select(&:creator?)
  end

  def non_creator_tags
    @non_creator_tags ||= entry.tags.reject(&:creator?)
  end

  def cover_url
    url_for entry.cover.variant(resize_to_limit: [450, 450])
  end
end
