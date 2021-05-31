class TagResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search_query = ->(params:) do
    scope.containing(params[:q])
  end

  field :name, as: :text, required: true, sortable: true, link_to_resource: true
  field :description, as: :trix, always_show: true, attachments_disabled: true

  field :tag_category, as: :has_one
  field :entries, as: :has_many

  filter TagCategoryFilter
end
