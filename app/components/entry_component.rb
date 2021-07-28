class EntryComponent < ViewComponent::Base
  include IconHelper
  include HighlightHelper
  include LinksHelper

  def initialize(entry:)
    @entry = entry
  end

  attr_reader :entry

  def creator_tags
    @creator_tags ||= entry.tags.select(&:creator?)
  end

  def non_creator_tags
    @non_creator_tags ||= entry.tags.reject(&:creator?)
  end
end
