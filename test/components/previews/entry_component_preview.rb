class EntryComponentPreview < ViewComponent::Preview
  def default
    render(EntryComponent.new(entry: entry))
  end

  def many_creators
    render(EntryComponent.new(entry: entry({tags: [
      tag("Creator #1", "Creators"),
      tag("Creator #2", "Creators"),
      tag("Creator #3", "Creators"),
      tag("Creator #4", "Creators"),
      tag("Creator #5", "Creators"),
      tag("Creator #6", "Creators"),
      tag("Creator #7", "Creators"),
      tag("Creator #8", "Creators"),
      tag("Creator #9", "Creators"),
      tag("Creator #10", "Creators"),
      tag("Category #1", "Categories"),
      tag("Category #2", "Categories"),
      tag("Locations", "Locations"),
      tag("Flavour", "Misc.")
    ]})))
  end

  def many_tags
    render(EntryComponent.new(entry: entry({tags: [
      tag("Creator #1", "Creators"),
      tag("Creator #2", "Creators"),
      tag("Category #1", "Categories"),
      tag("Category #2", "Categories"),
      tag("Category #3", "Categories"),
      tag("Category #4", "Categories"),
      tag("Category #5", "Categories"),
      tag("Category #6", "Categories"),
      tag("Category #7", "Categories"),
      tag("Category #8", "Categories"),
      tag("Category #9", "Categories"),
      tag("Category #10", "Categories"),
      tag("Locations", "Locations"),
      tag("Flavour", "Misc.")
    ]})))
  end

  def many_links
    render(EntryComponent.new(entry: entry({links: [
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something"),
      link("https://www.morkborg.com/something")
    ]})))
  end

  private

  def default_entry_params
    {
      name: "An example entry",
      description: <<~HTML,
        <p>Here we have some description content with <strong>styling</strong> applied...</p>
        <p>It's not super exciting, but it gives us an indication of how this will look.</p>
      HTML
      cover: cover,
      links: [
        link("https://www.morkborg.com/something"),
        link("https://something.itch.io/something")
      ],
      tags: [
        tag("Creator #1", "Creators"),
        tag("Creator #2", "Creators"),
        tag("Category #1", "Categories"),
        tag("Category #2", "Categories"),
        tag("Locations", "Locations"),
        tag("Flavour", "Misc.")
      ]
    }
  end

  def entry(params = {})
    Entry.new default_entry_params.merge(params)
  end

  def cover
    ActiveStorage::Attachment.where(record_type: "Entry", name: "cover").first&.blob
  end

  def link(address)
    Link.new(address: address)
  end

  def tag(name, category_name)
    Tag.new(
      name: name,
      tag_category: tag_categories[category_name]
    )
  end

  def tag_categories
    @tag_categories ||= Hash.new do |hash, key|
      hash[key] = TagCategory.new(name: key)
    end
  end
end
