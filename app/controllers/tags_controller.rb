class TagsController < ApplicationController
  def index
    @tag_categories = TagCategory.all.includes(:tags)
  end

  def show
    @tag = Tag.with_includes.find(params[:id])
  end
end
