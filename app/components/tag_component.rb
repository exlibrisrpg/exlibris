class TagComponent < ViewComponent::Base
  with_collection_parameter :tag

  attr_reader :tag

  delegate :name, to: :tag

  def initialize(tag:, count: nil)
    @tag = tag
    @count = count
  end

  def count
    content_tag(:small, "(#{@count})") if @count.present?
  end

  def path
    tag
  end

  def title
    tag.description.to_plain_text.presence || nil
  end
end
