# frozen_string_literal: true

class SectionLocation < ApplicationRecord
  belongs_to :location
  belongs_to :section
  belongs_to :reservation, required: false
end
