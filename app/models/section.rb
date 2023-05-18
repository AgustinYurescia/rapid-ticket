# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :show
  has_many :section_locations
  has_many :locations, through: :section_locations
end
