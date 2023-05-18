# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :place
  has_many :section_locations
  has_many :sections, through: :section_locations
end
