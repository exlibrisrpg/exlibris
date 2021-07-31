class TagsController < ApplicationController
  def index
    @tag_categories = TagCategory.all.includes(tags: :rich_text_description)
  end

  def show
    @tag = Tag.with_includes.find(params[:id])
    set_page_and_extract_portion_from @tag.entries.with_includes

    if request.path != tag_path(@tag)
      redirect_to @tag, status: :moved_permanently
    end
  end
end
