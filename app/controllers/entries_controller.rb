class EntriesController < ApplicationController
  def index
    set_page_and_extract_portion_from Entry.all.by_name.with_includes
  end

  def show
    @entry = entry_scope.with_includes.find(params[:id])

    if request.path != entry_path(@entry)
      redirect_to entry_path(@entry), status: :moved_permanently
    end
  end

  private

  def current_system
    if request.subdomain.present? && request.subdomain != "www"
      @current_system ||= System.find_by!(slug: request.subdomain)
    end
  end

  def entry_scope
    current_system&.entries || Entry.all
  end
end
