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

ActiveRecord::Schema.define(version: 20150510134330) do

  create_table "applies", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "event_id",   limit: 4
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.integer  "age",        limit: 4
    t.string   "sex",        limit: 255
    t.integer  "approved",   limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cities", ["code"], name: "index_cities_on_code", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.integer  "to_user_id",          limit: 4
    t.integer  "reply_to_user_id",    limit: 4
    t.integer  "reply_to_comment_id", limit: 4
    t.text     "content",             limit: 65535
    t.integer  "p_user_id",           limit: 4
    t.integer  "p_comment_id",        limit: 4
    t.integer  "commentable_id",      limit: 4
    t.string   "commentable_type",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "commentable", using: :btree
  add_index "comments", ["p_comment_id"], name: "index_comments_on_p_comment_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.string   "name",        limit: 255
    t.string   "address",     limit: 255
    t.string   "logo",        limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "fee_type",    limit: 4
    t.string   "fee",         limit: 255
    t.integer  "max_count",   limit: 4
    t.integer  "min_count",   limit: 4
    t.integer  "approved",    limit: 4,     default: 0
    t.text     "content",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photos_path", limit: 255
    t.string   "city_code",   limit: 255
    t.integer  "city_id",     limit: 4
    t.integer  "weight",      limit: 4,     default: 0
  end

  create_table "events_users", force: :cascade do |t|
    t.integer "event_id", limit: 4
    t.integer "user_id",  limit: 4
  end

  add_index "events_users", ["event_id"], name: "index_events_users_on_event_id", using: :btree
  add_index "events_users", ["user_id"], name: "index_events_users_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.string   "name",       limit: 255
    t.string   "avatar",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "imageable_id",   limit: 4
    t.string   "imageable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_classifies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.integer  "question_classify_id", limit: 4
    t.string   "a",                    limit: 255
    t.string   "b",                    limit: 255
    t.string   "c",                    limit: 255
    t.string   "d",                    limit: 255
    t.string   "answer",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "taxons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "position",   limit: 4
    t.integer  "parent",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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
    t.string   "hobby",      limit: 255
    t.string   "weixin_id",  limit: 255
  end

  add_index "users", ["email", "password"], name: "index_users_on_email_and_password", using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
