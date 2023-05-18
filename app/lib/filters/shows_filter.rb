# frozen_string_literal: true

module Filters
  class ShowsFilter < DataFilter
    def filter
      filter_by_prices_range
      filter_by_dates_range
      @data
    end

    private
      def filter_by_prices_range
        if @filter_params[:min_price].present? && @filter_params[:max_price].present?
          @data = @data.joins_sections.where('
            sections.price BETWEEN ? AND ?', @filter_params[:min_price], @filter_params[:max_price]).distinct
        else
          if @filter_params[:min_price].present?
            @data = @data.joins_sections.where('sections.price >= ?', @filter_params[:min_price]).distinct
          end
          if max_price.present?
            @data = @data.joins_sections.where('sections.price <= ?', @filter_params[:max_price]).distinct
          end
        end
      end

      def filter_by_dates_range
        if @filter_params[:date_from].present? && @filter_params[:date_to].present?
          @data = @data.where('
            shows.day_and_hour::date BETWEEN ? AND ?', @filter_params[:date_from], @filter_params[:date_to]).distinct
        else
          if @filter_params[:date_from].present?
            @data = @data.where('shows.day_and_hour::date >= ?', @filter_params[:date_from]).distinct
          end
          if @filter_params[:date_to].present?
            @data = @data.where('shows.day_and_hour::date <= ?', @filter_params[:date_to]).distinct
          end
        end
      end
  end
end
