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

ActiveRecord::Schema.define(version: 20140819110218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "content"
    t.integer  "upvotes"
    t.integer  "downvotes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_message"
    t.integer  "room_id"
  end

  create_table "rooms", force: true do |t|
    t.string   "topic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms_users", id: false, force: true do |t|
    t.integer "room_id"
    t.integer "user_id"
  end

  add_index "rooms_users", ["room_id", "user_id"], name: "index_rooms_users_on_room_id_and_user_id", using: :btree
  add_index "rooms_users", ["user_id"], name: "index_rooms_users_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
