class EntryTileComponentPreview < ViewComponent::Preview
  def default
    render(EntryTileComponent.new(entry: Entry.last))
  end
end
