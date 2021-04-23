module SearchHelper
  def search_highlight(text, phrases, options = {})
    text = sanitize(text) if options.fetch(:sanitize, true)

    if text.blank? || phrases.blank?
      text || ""
    else
      match = Array(phrases).map do |p|
        Regexp === p ? p.to_s : Regexp.escape(p)
      end.join("|")

      matcher = /(#{match})/i
      highlighter = options.fetch(:highlighter, '<mark>\1</mark>')

      transliterated_text = ActiveSupport::Inflector.transliterate(text).downcase
      split_text = transliterated_text.split(matcher)
      matches = transliterated_text.scan(matcher).flatten

      highlighted_text = ""

      split_text.each do |split|
        original_split = text[0, split.size]

        text[0, split.size] = ""

        highlighted_split = if matches.include?(split)
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
