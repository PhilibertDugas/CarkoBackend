# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170612012439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "firebase_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_id"
    t.integer "vehicule_id"
    t.string "account_id"
    t.string "bank_last_4_digits"
    t.string "bank_name"
    t.string "token"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["firebase_id"], name: "index_firebase_id"
    t.index ["vehicule_id"], name: "index_customer_vehicule_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.integer "range"
    t.money "price", scale: 2
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_url"
    t.integer "target_audience"
    t.string "label"
  end

  create_table "parkings", id: :serial, force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "photo_url"
    t.money "price", scale: 2
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "customer_id"
    t.json "availability_info"
    t.boolean "is_available"
    t.boolean "is_complete", default: false
    t.string "multiple_photo_urls", default: [], array: true
    t.index ["customer_id"], name: "index_parking_customer_id"
  end

  create_table "reservations", id: :serial, force: :cascade do |t|
    t.boolean "is_active"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.integer "parking_id"
    t.float "total_cost"
    t.integer "vehicule_id"
    t.string "charge"
    t.integer "event_id"
    t.index ["customer_id"], name: "index_customer_id"
    t.index ["event_id"], name: "index_reservation_event_id"
    t.index ["parking_id"], name: "index_parking_id"
    t.index ["vehicule_id"], name: "index_reservation_vehicule_id"
  end

  create_table "vehicules", id: :serial, force: :cascade do |t|
    t.string "license_plate"
    t.string "make"
    t.string "model"
    t.string "year"
    t.string "color"
    t.string "province"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_vehicule_customer_id"
  end

  add_foreign_key "parkings", "customers"
end
