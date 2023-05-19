# frozen_string_literal: true

class SectionLocation < ApplicationRecord
  belongs_to :location
  belongs_to :section
  belongs_to :reservation, required: false

  scope :availables, -> { where('section_locations.reservation_id IS NULL') }
  scope :not_availables, -> { where('section_locations.reservation_id IS NOT NULL') }
end
