class MetaTagsComponent < ViewComponent::Base
  def initialize(target:, title: nil, url: nil)
    @target = target
    @title = title
    @url = url
  end

  private

  def before_render
    set_meta_tags computed_meta_tags
  end

  def computed_meta_tags
    default_meta_tags.merge(target_meta_tags)
  end

  def default_meta_tags
    {
      site: t("application.name"),
      title: title,
      description: t("application.tagline"),
      reverse: true,
      image_src: asset_url("exlibris_yellow_social.jpg"),
      canonical: canonical,
      og: {
        title: :title,
        description: :description,
        site_name: :site,
        image: :image_src,
        url: :canonical
      },
      twitter: {
        card: "summary_large_image"
      }
    }
  end

  def target_meta_tags
    @target&.to_meta_tags || {}
  end

  def title
    @title || t("application.name")
  end

  def canonical
    if @target.present?
      full_url_for @target
    else
      @url || root_url
    end
  end
end
