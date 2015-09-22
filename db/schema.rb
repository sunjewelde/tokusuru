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

ActiveRecord::Schema.define(version: 20150919223427) do

  create_table "borrowings", force: :cascade do |t|
    t.integer  "borrower_id"
    t.integer  "borrowed_item_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.date     "start_day"
    t.date     "end_day"
  end

  add_index "borrowings", ["borrowed_item_id", "borrower_id"], name: "index_borrowings_on_borrowed_item_id_and_borrower_id", unique: true
  add_index "borrowings", ["borrowed_item_id"], name: "index_borrowings_on_borrowed_item_id"
  add_index "borrowings", ["borrower_id"], name: "index_borrowings_on_borrower_id"

# Could not dump table "items" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
