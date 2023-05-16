# frozen_string_literal: true

class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :document_number, null: false
      t.string :name, null: false
      t.string :phone_number, null: false
      t.references :user_role, null: false, foreign_key: true
      t.timestamps
    end
  end
end
