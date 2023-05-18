# frozen_string_literal: true

module Sorters
  class ShowsSorter < DataSorter
    def sort
      if @sorter_params[:sort_type].present? && @sorter_params[:sort_type] == 'desc'
        @data.order(@sorter_params[:sort_by] => :desc)
      else
        @data.order(@sorter_params[:sort_by] => :asc)
      end
    end
  end
end
