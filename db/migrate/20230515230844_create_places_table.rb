# frozen_string_literal: true

class CreatePlacesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.timestamps
    end
  end
end
