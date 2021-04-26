class Admin::TagsController < Admin::AdminController
  def index
    @tags = Tag.all
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
    @tag = Tag.includes(:tag_category).find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update(tag_params)
      redirect_to [:admin, @tag]
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])

    @tag.destroy

    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :tag_category_id)
  end
end
