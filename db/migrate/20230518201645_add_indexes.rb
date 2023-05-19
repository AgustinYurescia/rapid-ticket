class AddIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :sections, :price
    add_index :shows, :day_and_hour
  end
end
