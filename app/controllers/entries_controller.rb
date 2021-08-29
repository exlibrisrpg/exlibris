class EntriesController < ApplicationController
  def index
    set_page_and_extract_portion_from Entry.all.by_name.with_includes
  end

  def show
    @entry = Entry.with_includes.find(params[:id])

    if request.path != entry_path(@entry)
      redirect_to @entry, status: :moved_permanently
    end
  end

  def random
    @entry = Entry.limit(1).order("RANDOM()").first
    redirect_to @entry
  end
end
