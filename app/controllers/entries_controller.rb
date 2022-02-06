class EntriesController < ApplicationController
  def index
    set_page_and_extract_portion_from Current.system.entries.by_name.with_includes
  end

  def show
    @entry = Current.system.entries.with_includes.find(params[:id])

    if request.path != entry_path(@entry)
      redirect_to entry_path(@entry), status: :moved_permanently
    end
  end
end
