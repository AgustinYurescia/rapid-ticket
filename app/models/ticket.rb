# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user
  has_many :locations
end
