# frozen_string_literal: true

class CreateSectionsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.float :price, null: false
      t.string :currency, null: false
      t.string :name, null: false
      t.references :show
      t.timestamps
    end
  end
end
