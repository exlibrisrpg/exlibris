class LinkResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  self.visible_on_sidebar = false
  self.ordering = {
    visible_on: :association,
    actions: {
      higher: -> { record.move_higher },
      lower: -> { record.move_lower },
      to_top: -> { record.move_to_top },
      to_bottom: -> { record.move_to_bottom }
    }
  }

  field :address, as: :text
  field :entry, as: :belongs_to
end
