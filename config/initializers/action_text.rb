ActiveSupport.on_load :action_text_rich_text do
  include(Module.new do
    extend ActiveSupport::Concern

    included do
      scope :with_body_containing, ->(query) { where <<~SQL, query: query }
        to_tsvector('en', plain_text_body) @@ websearch_to_tsquery(unaccent(:query))
      SQL

      before_save do
        self.plain_text_body = to_plain_text
      end
    end
  end)
end
