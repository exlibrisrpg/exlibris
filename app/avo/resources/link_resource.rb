class LinkResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  self.visible_on_sidebar = false

  field :address, as: :text
  field :entry, as: :has_one
end
