# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :show
  belongs_to :user
  has_many :section_locations

  after_create :update_sections_availability

  private
    def update_sections_availability
      section_locations.includes(:section).each do | section_location |
        section_location.section.available_locations_count -= 1
        section_location.section.save
      end
    end
end
