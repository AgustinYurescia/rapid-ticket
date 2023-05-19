# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_18_201645) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "location_number"
    t.string "location_row"
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_locations_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "city", null: false
    t.string "state", null: false
    t.string "country", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.float "total", null: false
    t.string "currency", null: false
    t.bigint "user_id", null: false
    t.bigint "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["show_id"], name: "index_reservations_on_show_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "section_locations", force: :cascade do |t|
    t.bigint "reservation_id"
    t.bigint "section_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_section_locations_on_location_id"
    t.index ["reservation_id"], name: "index_section_locations_on_reservation_id"
    t.index ["section_id"], name: "index_section_locations_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.float "price", null: false
    t.string "currency", null: false
    t.string "name", null: false
    t.bigint "show_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "available_locations_count"
    t.boolean "without_numeration", default: false
    t.index ["price"], name: "index_sections_on_price"
    t.index ["show_id"], name: "index_sections_on_show_id"
  end

  create_table "shows", force: :cascade do |t|
    t.datetime "day_and_hour", null: false
    t.string "name", null: false
    t.string "show_type", null: false
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_and_hour"], name: "index_shows_on_day_and_hour"
    t.index ["place_id"], name: "index_shows_on_place_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "document_number", null: false
    t.string "name", null: false
    t.string "phone_number", null: false
    t.bigint "user_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  add_foreign_key "users", "user_roles"
end
