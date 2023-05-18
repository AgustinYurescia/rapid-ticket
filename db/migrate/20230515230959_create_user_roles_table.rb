# frozen_string_literal: true

class CreateUserRolesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.string :name
      t.timestamps
    end
  end
end
