class Dashboard::LatestEntriesComponentPreview < ViewComponent::Preview
  def default
    entries = System.first.entries.take(10)
    render(Dashboard::LatestEntriesComponent.new(entries: entries))
  end
end
