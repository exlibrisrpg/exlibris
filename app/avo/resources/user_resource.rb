class UserResource < Avo::BaseResource
  self.title = :email
  self.search_query = ->(params:) do
    scope.where("users.email ILIKE :query", query: "%#{params[:q]}%")
  end

  field :email, as: :text, required: true, sortable: true, link_to_resource: true
  field :role, as: :select, enum: ::User.roles, required: true, sortable: true

  field :curated_systems, as: :has_many, through: :curation_roles
end
