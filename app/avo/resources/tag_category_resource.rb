class TagCategoryResource < Avo::BaseResource
  self.title = :name
  self.includes = []

  field :name, as: :text, required: true
  field :system, as: :belongs_to, required: true, default: -> do
    scope = authorization.apply_policy(System.all)
    if scope.one?
      scope.first.id
    end
  end
  field :short_description_required, as: :boolean

  field :tags, as: :has_many
end
