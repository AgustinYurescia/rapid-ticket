class ShowsController < ApplicationController
  before_action :permit_params

  def index
    cached_shows = Rails.cache.fetch(shows_cache_key) do
      shows = Show.all
      shows = ::Filters::ShowsFilter.new(shows, permitted_filter_params).filter if permitted_filter_params.present?
      shows = ::Sorters::ShowsSorter.new(shows, permitted_sort_params).sort if permitted_sort_params[:sort_by].present?
      shows
    end
    page_number = permitted_page_params[:page_number] || 1
    shows = cached_shows.page(page_number).per(15)
    render json: {
      shows: shows,
      page_info: {
        current_page: shows.current_page,
        total_pages: shows.total_pages
      }
    }
  end

  def get_available_sections
    show = Show.find_by(id: @permitted_params[:show_id])
    unless show.nil?
      response = { sections: show.sections }
    else
      response = { errors: 'Show does not exist' }
    end
    render json: response
  end

  def get_available_locations_for_section
    show = Show.find_by(id: @permitted_params[:show_id])
    unless show.nil?
      show_section_available_locations_data = Rails.cache.fetch(available_locations_cache_key) do
        show.available_locations_for_section(@permitted_params[:section_id])
      end
      response = { available_locations: show_section_available_locations_data }
    else
      response = { errors: 'Show does not exist' }
    end
    render json: response
  end

  private
    def permit_params
      @permitted_params = params.permit(:show_id, :section_id, :min_price, :max_price, :date_from, :date_to, :sort_by, :sort_type, :page_number)
    end

    def permitted_filter_params
      @permitted_params.select { |key, _value| %w[min_price max_price date_from date_to].include?(key) }
    end

    def permitted_sort_params
      @permitted_params.select { |key, _value| %w[sort_by sort_type].include?(key) }
    end

    def permitted_page_params
      @permitted_params.select { |key, _value| %w[page_number].include?(key) }
    end

    def shows_cache_key
      shows = Show.all

      filters_key = permitted_filter_params.present? ? permitted_filter_params.to_h : 'no_filters'

      sorts_key = permitted_sort_params.present? ? permitted_sort_params.to_h : 'no_sort'

      page_key = permitted_page_params.present? ? permitted_page_params.to_h : 'no_page'

      "list_shows/#{filters_key}/#{sorts_key}/#{page_key}/#{shows.size}/#{shows.maximum(:id)}/#{shows.maximum(:updated_at)}"
    end

    def available_locations_cache_key
      show_id = @permitted_params[:show_id]
      section_id = @permitted_params[:section_id]
      show = Show.find_by(id: show_id)
      show_sections_max_updated_at = show.sections.maximum(:updated_at)
      available_section_locations_quantity = SectionLocation.where('
        section_locations.section_id = ? AND section_locations.reservation_id IS NULL', @permitted_params[:section_id]
      ).count

      "available_locations/show_#{show_id}/section_#{section_id}/#{show_sections_max_updated_at}/#{available_section_locations_quantity}"
    end
end
