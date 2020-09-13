# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_13_140955) do

  create_table "invoices", force: :cascade do |t|
    t.integer "patient_id"
    t.integer "order_id"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_invoices_on_order_id"
    t.index ["patient_id"], name: "index_invoices_on_patient_id"
  end

  create_table "orders", id: false, force: :cascade do |t|
    t.string "order_id"
    t.string "category"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_orders_on_order_id", unique: true
  end

  create_table "patients", id: false, force: :cascade do |t|
    t.string "patient_id"
    t.string "patient_name"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_patients_on_patient_id", unique: true
  end

end
