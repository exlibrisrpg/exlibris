class TagsController < ApplicationController
  def index
    @tag_categories = TagCategory.all.includes(tags: :rich_text_description)
  end

  def show
    @tag = Tag.with_includes.find(params[:id])
  end
end
