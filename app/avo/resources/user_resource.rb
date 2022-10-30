class UserResource < Avo::BaseResource
  self.title = :email
  self.search_query = -> do
    scope.where("users.email ILIKE :query", query: "%#{params[:q]}%")
  end

  field :email, as: :text, required: true, sortable: true, link_to_resource: true
  field :role, as: :select, enum: ::User.roles, required: true, sortable: true
  field :password, as: :hidden, default: -> { SecureRandom.base58(10) }

  field :curated_systems, as: :has_many, through: :curation_roles

  action ResetPassword

  filter UserRoleFilter
  filter UserCuratesSystemFilter
end
