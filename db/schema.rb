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

ActiveRecord::Schema.define(version: 20161213023243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "firebase_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "stripe_id"
    t.integer  "vehicule_id"
    t.string   "account_id"
    t.index ["email"], name: "index_customers_on_email", unique: true, using: :btree
    t.index ["vehicule_id"], name: "index_customer_vehicule_id", using: :btree
  end

  create_table "parkings", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "photo_url"
    t.money    "price",             scale: 2
    t.string   "address"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "description"
    t.integer  "customer_id"
    t.json     "availability_info"
    t.boolean  "is_available"
    t.index ["customer_id"], name: "index_parking_customer_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.boolean  "is_active"
    t.string   "start_time"
    t.string   "stop_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
    t.integer  "parking_id"
    t.float    "total_cost"
    t.integer  "vehicule_id"
    t.string   "charge"
    t.index ["customer_id"], name: "index_customer_id", using: :btree
    t.index ["parking_id"], name: "index_parking_id", using: :btree
    t.index ["vehicule_id"], name: "index_reservation_vehicule_id", using: :btree
  end

  create_table "vehicules", force: :cascade do |t|
    t.string   "license_plate"
    t.string   "make"
    t.string   "model"
    t.string   "year"
    t.string   "color"
    t.string   "province"
    t.integer  "customer_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["customer_id"], name: "index_vehicule_customer_id", using: :btree
  end

  add_foreign_key "parkings", "customers"
end
