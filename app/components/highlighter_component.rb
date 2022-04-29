class HighlighterComponent < ViewComponent::Base
  def initialize(text:, phrases:)
    @text = text
    @phrases = phrases
  end

  def call
    helpers.search_highlight(@text, @phrases, highlighter: highlighter)
  end

  def highlighter
    if request.variant.morkborg?
      '<mark class="tw-bg-transparent tw-text-accent-9">\1</mark>'
    else
      <<~'MARK'
        <mark class="tw-bg-transparent tw-relative"><span class="tw-bg-accent-9 tw-absolute -tw-inset-1 tw-rounded" aria-hidden="true"></span><span class="tw-relative tw-text-accent-1">\1</span></mark>
      MARK
    end
  end
end
