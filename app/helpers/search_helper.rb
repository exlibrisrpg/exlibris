module SearchHelper
  def search_highlight(text, phrases, options = {})
    text = sanitize(text) if options.fetch(:sanitize, true)

    if text.blank? || phrases.blank?
      text || ""
    else
      match = Array(phrases).map do |p|
        ActiveSupport::Inflector.transliterate(p).downcase
      end.map do |p|
        Regexp === p ? p.to_s : Regexp.escape(p)
      end.join("|")

      matcher = /(#{match})/i
      highlighter = options.fetch(:highlighter, '<mark class="tw-bg-secondary-9/[.65] tw-text-accent-9">\1</mark>')

      transliterated_text = ActiveSupport::Inflector.transliterate(text).downcase
      split_text = transliterated_text.split(matcher)
      matches = transliterated_text.scan(matcher).flatten

      highlighted_text = ""

      split_text.each_with_index do |split, index|
        original_split = text[0, split.size]

        text[0, split.size] = ""

        previous_split_opens_html_tag =
          index > 0 && split_text[index - 1].match?(/<\/?$/)

        highlighted_split = if matches.include?(split) && !previous_split_opens_html_tag
          original_split.gsub(/(.+)/i, highlighter)
        else
          original_split
        end

        highlighted_text << highlighted_split
      end

      highlighted_text
    end.html_safe
  end
end
