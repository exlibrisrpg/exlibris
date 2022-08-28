class SystemTokenComponent < ViewComponent::Base
  attr_reader :name, :count, :live

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
      "tw-bg-white/20 tw-shadow tw-border-white tw-rounded-full tw-inline-flex tw-items-center tw-transition tw-px-4 tw-py-2 tw-border-2 tw-gap-2 tw-select-none tw-relative tw-overflow-hidden tw-group",
      "hover:tw-bg-white/40 hover:tw-shadow-md focus:tw-bg-white/40 focus:tw-shadow-md": live,
      "tw-opacity-60 tw-cursor-default": !live
    )
  end

  def url
    return "#" unless live && @url.present?

    @url
  end
end
