class SystemResource < Avo::BaseResource
  self.title = :name
  self.search_query = ->(params:) do
    scope.where("systems.name ILIKE :query", query: "%#{params[:q]}%")
  end

  field :name, as: :text, required: true, sortable: true, link_to_resource: true
  field :tagline, as: :text
  field :slug, as: :text
  field :live, as: :boolean
  field :footer, as: :trix, attachments_disabled: true

  field :curators, as: :has_many, through: :curation_roles
end
