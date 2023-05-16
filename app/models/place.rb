# frozen_string_literal: true

class Place < ApplicationRecord
  has_many :shows
end