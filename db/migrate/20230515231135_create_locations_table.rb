# frozen_string_literal: true

class CreateLocationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :location_number, null: true
      t.string :location_row, null: true
      t.references :place
      t.timestamps
    end
  end
end
