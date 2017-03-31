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

ActiveRecord::Schema.define(version: 20170328050355) do

  create_table "enlists", force: :cascade do |t|
    t.integer  "player_id"
    t.string   "name"
    t.string   "qq"
    t.string   "company"
    t.string   "address"
    t.string   "mobile"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "mold"
    t.string   "province"
    t.string   "training_time"
    t.boolean  "skill_one",     default: false
    t.boolean  "skill_two",     default: false
    t.integer  "sign_number",   default: 0
  end

  create_table "gensees", force: :cascade do |t|
    t.integer  "uid",        limit: 20
    t.string   "area"
    t.string   "company"
    t.integer  "joinTime",   limit: 20
    t.integer  "leaveTime",  limit: 20
    t.string   "nickname"
    t.string   "mobile"
    t.integer  "device"
    t.string   "ip"
    t.string   "name"
    t.integer  "video_id"
    t.string   "mold"
    t.string   "sdk"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "see_time"
  end

  create_table "players", force: :cascade do |t|
    t.string   "username"
    t.string   "global_id"
    t.string   "mobile"
    t.string   "email"
    t.string   "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "sex"
    t.string   "mobile"
    t.string   "logo"
    t.string   "position"
    t.integer  "age"
    t.string   "qq"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email", "password"], name: "index_users_on_email_and_password"

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "videos", force: :cascade do |t|
    t.string   "zkey"
    t.string   "zurl"
    t.string   "lkey"
    t.string   "lurl"
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "start_time"
  end

end
