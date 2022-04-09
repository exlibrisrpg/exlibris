class RichTextComponent < ViewComponent::Base
  delegate :render_action_text_content, to: :helpers

  def initialize(rich_text:)
    @rich_text = rich_text
  end

  def render?
    @rich_text.present?
  end

  def call
    content_tag :div, rich_text_html, class: "tw-max-w-prose tw-space-y-2 tw-text-base"
  end

  def rich_text_html
    render_action_text_content(@rich_text.body)
  end
end
