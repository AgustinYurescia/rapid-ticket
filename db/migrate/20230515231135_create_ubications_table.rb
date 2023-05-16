# frozen_string_literal: true

class CreateLocationsTable < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.boolean :available, null: false, default: true
      t.string :location_number, null: true
      t.string :location_row, null: true
      t.references :section, null: false, foreign_key: true
      t.references :ticket, null: true, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.timestamps
    end
  end
end
