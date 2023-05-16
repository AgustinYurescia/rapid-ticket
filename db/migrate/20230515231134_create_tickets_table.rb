# frozen_string_literal: true

class CreateTicketsTable < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.float :total, null: false
      t.string :currency, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
