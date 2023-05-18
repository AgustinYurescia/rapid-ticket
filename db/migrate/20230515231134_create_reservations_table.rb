# frozen_string_literal: true

class CreateReservationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.float :total, null: false
      t.string :currency, null: false
      t.references :user, null: false
      t.references :show, null: false
      t.timestamps
    end
  end
end
