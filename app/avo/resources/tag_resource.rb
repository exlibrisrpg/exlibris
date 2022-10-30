class TagResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search_query = -> do
    scope.containing(params[:q])
  end
  self.resolve_query_scope = ->(model_class:) do
    model_class.by_name
  end
  self.show_controls = -> do
    back_button
    delete_button
    edit_button
    link_to "View Tag", view_context.main_app.tag_url(record, subdomain: record.system.slug), style: :primary, color: "emerald", icon: "heroicons/solid/link"
  end

  field :name, as: :text, required: true, sortable: true, link_to_resource: true
  field :system, as: :belongs_to, required: true, default: -> do
    scope = authorization.apply_policy(System.all)
    if scope.one?
      scope.first.id
    end
  end
  field :short_description, as: :text, visible: ->(resource:) { resource.model.tag_category&.short_description_required }, required: -> { record.tag_category&.short_description_required }, hide_on: :index
  field :order, as: :number, sortable: true

  field :description, as: :trix, always_show: true, attachments_disabled: true

  field :tag_category, as: :belongs_to
  field :entries, as: :has_many

  field :search_name, as: :text, as_description: true, hide_on: :all do |model|
    "#{model.tag_category.name} > #{model.name}"
  end

  filter TagCategoryFilter
end
