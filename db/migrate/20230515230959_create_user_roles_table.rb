# frozen_string_literal: true

class CreateUserRolesTable < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string :name
      t.timestamps
    end
  end
end
