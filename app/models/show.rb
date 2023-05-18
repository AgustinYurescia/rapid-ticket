# frozen_string_literal: true

class Show < ApplicationRecord
  belongs_to :place
  has_many :reservations
  has_many :sections

  scope :pendings, -> { where('shows.day_and_hour > ?', DateTime.now) }

  def self.joins_sections
    joins('
      INNER JOIN sections
      ON shows.id = sections.show_id
    ')
  end

  def available_locations_for_section(section_id)
    locations_data = []
    section = sections.find_by(id: section_id)
    unless section.nil?
      if section.without_numeration
        locations_data = {
          message: 'Locations without numeration',
          locations_availables: section.available_locations_count,
          price: section.price
        }
      else
        available_section_locations = section.section_locations.includes(:location).where('section_locations.reservation_id IS NULL')
        available_section_locations.each do | section_location |
          location_data = {
            location_number: section_location.location.location_number,
            location_row: section_location.location.location_row,
            price: section.price
          }
          locations_data << location_data
        end
      end
    end
    locations_data
  end
end
