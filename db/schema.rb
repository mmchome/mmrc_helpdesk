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

ActiveRecord::Schema.define(version: 20140211094021) do

  create_table "issue_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.string   "updateUserId"
    t.boolean  "isSolution"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.boolean  "isAssigned"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tittle"
    t.integer  "user_id"
    t.integer  "issue_type_id"
  end

  add_index "tickets", ["issue_type_id"], name: "index_tickets_on_issue_type_id"
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id"

  create_table "user_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.integer  "phone_ext"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_types_id"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["user_types_id"], name: "index_users_on_user_types_id"

end
