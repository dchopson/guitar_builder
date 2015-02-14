# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150125211332) do

  create_table "guitars", force: true do |t|
    t.string   "body_style"
    t.string   "body_wood"
    t.string   "body_finish"
    t.boolean  "pick_guard"
    t.string   "fretboard_wood"
    t.string   "fretboard_finish"
    t.boolean  "fretboard_markers"
    t.string   "neck_wood"
    t.string   "neck_finish"
    t.string   "tuning_peg_style"
    t.string   "tuning_peg_layout"
    t.string   "string_type"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guitars", ["order_id"], name: "index_guitars_on_order_id"

  create_table "orders", force: true do |t|
    t.string   "number"
    t.date     "completion_date"
    t.string   "status"
    t.string   "delivery_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "telephone"
    t.string   "email"
    t.string   "cc_number"
    t.integer  "user_id"
    t.integer  "lock_version",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

end
