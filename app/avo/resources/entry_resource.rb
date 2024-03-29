class EntryResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search_query = -> do
    scope.containing(params[:q])
  end
  self.show_controls = -> do
    back_button
    delete_button
    edit_button
    link_to "View Entry", view_context.main_app.entry_url(record, subdomain: record.system.slug), style: :primary, color: "emerald", icon: "heroicons/solid/link"
  end

  field :name, as: :text, required: true, sortable: true, link_to_resource: true
  field :system, as: :belongs_to, required: true, default: -> do
    scope = authorization.apply_policy(System.all)
    if scope.one?
      scope.first.id
    end
  end
  field :description, as: :trix, default: Entry::DEFAULT_DESCRIPTION, always_show: true, required: true, attachments_disabled: true
  field :cover, as: :file, is_image: true, link_to_resource: true

  field :created_at, as: :date_time, readonly: true, sortable: true, hide_on: [:new, :edit]
  field :updated_at, as: :date_time, readonly: true, sortable: true, hide_on: [:new, :edit]

  field :links, as: :has_many
  field :tags, as: :has_and_belongs_to_many, searchable: true, attach_scope: -> { query.for_system(parent.system) }
  field :tag_ids,
    name: "Tags",
    as: :tags,
    hide_on: [:show, :index, :new],
    close_on_select: false,
    enforce_suggestions: true,
    format_using: ->(value) { Tag.labels_for(value) },
    suggestions: -> { Tag.suggestions_for(record.system).as_json(only: [:value, :label]) }

  field :category, as: :text, hide_on: :show do |model|
    model.category_tags&.first&.name
  end

  filter CategoryFilter
end
