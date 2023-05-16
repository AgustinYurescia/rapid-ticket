# frozen_string_literal: true

class Ubication < ApplicationRecord
  belongs_to :section
  belongs_to :show
  belongs_to :ticket
end