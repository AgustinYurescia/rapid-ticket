# frozen_string_literal: true

class AddNewFieldsToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :available_locations_count, :integer
    add_column :sections, :without_numeration, :boolean, default: false
  end
end
