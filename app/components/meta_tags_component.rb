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
      site: Current.system&.full_name,
      title: title,
      description: Current.system&.tagline,
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
    @title || Current.system&.full_name || "Ex Libris"
  end

  def canonical
    if @target.present?
      polymorphic_url(@target, subdomain: @target.system.slug)
    else
      @url || dashboard_url(subdomain: Current.system&.slug)
    end
  end
end
