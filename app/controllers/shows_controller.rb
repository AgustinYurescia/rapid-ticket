class ShowsController < ApplicationController
  def index
    shows = Show.all
    shows = DataFilter.new(shows, permitted_filter_params).filter
    shows = DataSorter.new(shows, permitted_sort_params).sort
    shows = paginate(shows)
    render json: shows
  end

  private

  def permitted_filter_params
    params.permit!(:min_price, :max_price, :date_from, :date_to)
  end

  def permitted_sort_params
    params.permit!(:sort_by, :sort_type)
  end

  def permitted_page_params
    params.permit!(:page_number)
  end
end
