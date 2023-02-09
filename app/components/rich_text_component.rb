class RichTextComponent < ViewComponent::Base
  delegate :render_action_text_content, to: :helpers

  def initialize(rich_text:, search_term: nil)
    @rich_text = rich_text
    @search_term = search_term
  end

  def render?
    @rich_text.present?
  end

  def call
    content_tag :div, body, class: "tw-max-w-prose tw-space-y-2 tw-text-base richtext"
  end

  def rich_text_html
    render_action_text_content(@rich_text.body)
  end

  def body
    if @search_term
      render HighlighterComponent.new(text: rich_text_html, phrases: @search_term)
    else
      rich_text_html
    end
  end
end
