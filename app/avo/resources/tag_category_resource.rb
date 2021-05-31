class TagCategoryResource < Avo::BaseResource
  self.title = :name
  self.includes = []

  field :name, as: :text, required: true

  field :tags, as: :has_many
end
