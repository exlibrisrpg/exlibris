class SystemTokenComponent < ViewComponent::Base
  attr_reader :name, :count, :url, :live

  def initialize(name:, count:, url: nil, live: true)
    @name = name
    @count = count
    @url = url
    @live = live
  end

  def count?
    count.present?
  end

  def token_class
    class_names(
      "tw-bg-white/20 tw-shadow tw-border-white tw-rounded-full tw-inline-flex tw-items-center tw-transition tw-duration-200",
      "tw-px-4 tw-py-2 tw-border-2 tw-gap-2",
      "md:tw-px-6 md:tw-py-3 md:tw-border-3 md:tw-gap-3",
      "lg:tw-px-8 lg:tw-py-4 lg:tw-border-4 lg:tw-gap-4",
      "hover:tw-bg-white/40 hover:tw-shadow-md": live,
      "tw-opacity-60": !live
    )
  end

  def name_class
    class_names(
      "tw-font-brand tw-text-white tw-tracking-tight tw-drop-shadow-sm tw-flex-shrink-0 tw-font-extrabold",
      "tw-text-2xl",
      "md:tw-text-3xl",
      "lg:tw-text-5xl"
    )
  end

  def count_class
    class_names(
      "tw-font-brand tw-text-white tw-bg-white/30 tw-rounded-full tw-lining-nums tw-leading-none tw-drop-shadow-sm tw-flex-shrink-0 tw-font-extrabold",
      "tw-text-xl tw-px-2 tw-py-0.5",
      "md:tw-text-2xl md:tw-px-3",
      "lg:tw-text-4xl lg:tw-px-4 lg:tw-py-1"
    )
  end

  def wrapper_tag(&block)
    return link_to(url, class: token_class, &block) if url.present? && live

    content_tag(:div, class: token_class, &block)
  end

  def name_tag(&block)
    content_tag(:span, class: name_class, &block)
  end

  def count_tag
    content_tag(:span, @count, class: count_class)
  end
end
