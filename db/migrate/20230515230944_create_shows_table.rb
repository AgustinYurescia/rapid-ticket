# frozen_string_literal: true

class CreateShowsTable < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.datetime :day_and_hour, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.references :place, null: false, foreign_key: true
      t.timestamps
    end
  end
end
