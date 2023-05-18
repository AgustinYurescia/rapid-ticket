# frozen_string_literal: true

module Filters
  class DataFilter
    def initialize(data, filter_params)
      @data = data
      @filter_params = filter_params
    end
  end
end
