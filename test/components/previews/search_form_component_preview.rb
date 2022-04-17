# @display body_class "tw-bg-secondary-3 tw-text-secondary-12"
class SearchFormComponentPreview < ViewComponent::Preview
  def default
    render(SearchFormComponent.new(search: Search.new(query: "A")))
  end

  def with_tag_options
    render(SearchFormComponent.new(search: Search.new(query: "A", system: Current.system), opened: true))
  end

  def with_selected_tags
    render(SearchFormComponent.new(search: search))
  end

  private

  def search
    fake_search = Struct.new(:filter_tags, :tags) do
      def model_name
        ActiveModel::Name.new(Search)
      end

      def tags
        @tags || []
      end

      def persisted?
        false
      end
    end

    fake_search.new([Tag.new(name: "Johan Nohr")])
  end
end
