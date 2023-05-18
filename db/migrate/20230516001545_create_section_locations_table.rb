# frozen_string_literal: true

class CreateSectionLocationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :section_locations do |t|
      t.references :reservation, null: true
      t.references :section
      t.references :location
      t.timestamps
    end
  end
end
