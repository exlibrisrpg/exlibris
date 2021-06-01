class EntriesController < ApplicationController
  def index
    set_page_and_extract_portion_from Entry.all.with_includes
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      redirect_to @entry
    else
      render :new
    end
  end

  def show
    @entry = Entry.with_includes.find(params[:id])
  end

  def edit
    @entry = Entry.with_includes.find(params[:id])
  end

  def update
    @entry = Entry.with_includes.find(params[:id])

    if @entry.update(entry_params)
      redirect_to @entry
    else
      render :edit
    end
  end

  def destroy
    @entry = Entry.with_includes.find(params[:id])

    @entry.destroy

    redirect_to entries_path
  end

  private

  def entry_params
    params.require(:entry).permit(:name, :cover, :description, tag_ids: [])
  end
end
