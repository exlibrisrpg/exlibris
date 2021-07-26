# frozen_string_literal: true

class SocialMetaComponent < ViewComponent::Base
  def initialize(target:, title: nil, url: nil)
    @target = target
    @title = title
    @url = url
  end

  def title
    if target?
      return "#{@target.name} | #{site_name}"
    end

    if title?
      return "#{@title} | #{site_name}"
    end

    site_name
  end

  def site_name
    t "application.name"
  end

  def description
    if target?
      return @target.description.to_plain_text
    end

    t "application.tagline"
  end

  def image
    if @target.respond_to?(:cover) && @target.cover.attached?
      return @target.cover.url
    end

    asset_pack_url "media/images/potato_borg.png"
  end

  def url
    if target?
      return full_url_for @target
    end

    @url || root_url
  end

  def target?
    @target.present?
  end

  def title?
    @title.present?
  end
end
