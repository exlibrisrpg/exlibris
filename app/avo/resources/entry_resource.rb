class EntryResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search_query = ->(params:) do
    scope.containing(params[:q])
  end

  field :name, as: :text, required: true, sortable: true, link_to_resource: true
  field :description, as: :trix, default: Entry::DEFAULT_DESCRIPTION, always_show: true, required: true, attachments_disabled: true
  field :cover, as: :file, is_image: true, link_to_resource: true, hide_on: [:index]

  field :created_at, as: :date_time, readonly: true, sortable: true, hide_on: [:new, :edit]
  field :updated_at, as: :date_time, readonly: true, sortable: true, hide_on: [:new, :edit]

  field :links, as: :has_many
  field :tags, as: :has_and_belongs_to_many

  field :category, as: :text do |model|
    model.tags.where(tag_category: TagCategory.find_by(name: "Categories"))&.first&.name
  end

  filter CategoryFilter
end
