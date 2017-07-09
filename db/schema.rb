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

ActiveRecord::Schema.define(version: 20170407024428) do

  create_table "enlists", force: :cascade do |t|
    t.integer  "player_id",     limit: 4
    t.string   "name",          limit: 255
    t.string   "qq",            limit: 255
    t.string   "company",       limit: 255
    t.string   "address",       limit: 255
    t.string   "mobile",        limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "mold",          limit: 255
    t.string   "province",      limit: 255
    t.string   "training_time", limit: 255
    t.boolean  "skill_one",                 default: false
    t.boolean  "skill_two",                 default: false
    t.integer  "sign_number",   limit: 4,   default: 0
  end

  create_table "gensees", force: :cascade do |t|
    t.integer  "uid",        limit: 4
    t.string   "area",       limit: 255
    t.string   "company",    limit: 255
    t.integer  "joinTime",   limit: 4
    t.integer  "leaveTime",  limit: 4
    t.string   "nickname",   limit: 255
    t.string   "mobile",     limit: 255
    t.integer  "device",     limit: 4
    t.string   "ip",         limit: 255
    t.string   "name",       limit: 255
    t.integer  "video_id",   limit: 4
    t.string   "mold",       limit: 255
    t.string   "sdk",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "see_time",   limit: 4
  end

  create_table "players", force: :cascade do |t|
    t.string   "username",    limit: 255
    t.string   "global_id",   limit: 255
    t.string   "mobile",      limit: 255
    t.string   "email",       limit: 255
    t.string   "sex",         limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "sign_number", limit: 4,   default: 0
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.string   "sex",        limit: 255
    t.string   "mobile",     limit: 255
    t.string   "logo",       limit: 255
    t.string   "position",   limit: 255
    t.integer  "age",        limit: 4
    t.string   "qq",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email", "password"], name: "index_users_on_email_and_password", using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "zkey",       limit: 255
    t.string   "zurl",       limit: 255
    t.string   "lkey",       limit: 255
    t.string   "lurl",       limit: 255
    t.string   "name",       limit: 255
    t.string   "desc",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "start_time", limit: 255
  end

end
