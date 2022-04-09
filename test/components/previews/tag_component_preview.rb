class TagComponentPreview < ViewComponent::Preview
  def default
    render(TagComponent.new(tag: Tag.new(name: "Rules")))
  end

  def with_count
    render(TagComponent.new(tag: Tag.new(name: "Rules"), count: 123))
  end
end
