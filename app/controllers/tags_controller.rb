class TagsController < ApplicationController
  def index
    @tag_categories = Current.system.tag_categories.includes(tags: :rich_text_description)
  end

  def show
    @tag = Tag.includes(:rich_text_description).find(params[:id])
    set_page_and_extract_portion_from @tag.entries
    @entries = @page.records.strict_loading.includes(
      :links,
      :rich_text_description,
      cover_attachment: :blob,
      tags: [:tag_category, :rich_text_description]
    )

    if request.path != tag_path(@tag)
      redirect_to @tag, status: :moved_permanently
    end
  end
end
