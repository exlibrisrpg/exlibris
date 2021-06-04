class TagCategoryResource < Avo::BaseResource
  self.title = :name
  self.includes = []

  field :name, as: :text, required: true

  field :icon, as: :select, enum: ::TagCategory.icons, placeholder: "Choose icon."

  field :tags, as: :has_many
end
