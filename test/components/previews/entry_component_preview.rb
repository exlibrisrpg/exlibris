class EntryComponentPreview < ViewComponent::Preview
  def default
    render(EntryComponent.new(entry: Entry.last))
  end
end
