class Layout::Header::SecondaryNavComponentPreview < ViewComponent::Preview
  def default
    render(Layout::Header::SecondaryNavComponent.new(links: [
      {label: "Rules", path: "#"},
      {label: "Classes", path: "#"},
      {label: "Gear", path: "#"},
      {label: "Monsters/NPCs", path: "#"},
      {label: "Decor", path: "#"},
      {label: "Adventures", path: "#"},
      {label: "Etc.", path: "#"},
      {label: "Tools", path: "#"},
      {label: "Variants", path: "#"},
      {label: "Conversions", path: "#"}
    ]))
  end
end
