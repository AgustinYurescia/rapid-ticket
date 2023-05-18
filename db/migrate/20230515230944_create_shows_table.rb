# frozen_string_literal: true

class CreateShowsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :shows do |t|
      t.datetime :day_and_hour, null: false
      t.string :name, null: false
      t.string :show_type, null: false
      t.references :place
      t.timestamps
    end
  end
end
