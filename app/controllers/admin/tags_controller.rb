class Admin::TagsController < Admin::AdminController
  def index
    @tag_categories = TagCategory.all.includes(tags: :rich_text_description)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to [:admin, @tag]
    else
      render :new
    end
  end

  def show
    @tag = Tag.with_includes.find(params[:id])
  end

  def edit
    @tag = Tag.includes(:tag_category, :rich_text_description).find(params[:id])
  end

  def update
    @tag = Tag.includes(:rich_text_description).find(params[:id])

    if @tag.update(tag_params)
      redirect_to [:admin, @tag]
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.includes(:rich_text_description).find(params[:id])

    @tag.destroy

    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :description, :tag_category_id)
  end
end
