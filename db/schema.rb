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

ActiveRecord::Schema.define(version: 20150618065909) do

  create_table "applies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "name"
    t.string   "email"
    t.integer  "age"
    t.string   "sex"
    t.integer  "approved",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities", ["code"], name: "index_cities_on_code", unique: true

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.integer  "reply_to_user_id"
    t.integer  "reply_to_comment_id"
    t.text     "content"
    t.integer  "p_user_id"
    t.integer  "p_comment_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "commentable"
  add_index "comments", ["p_comment_id"], name: "index_comments_on_p_comment_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "name"
    t.string   "address"
    t.string   "logo"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "fee_type"
    t.string   "fee"
    t.integer  "max_count"
    t.integer  "min_count"
    t.integer  "approved",    default: 0
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photos_path"
    t.string   "city_code"
    t.integer  "city_id"
    t.integer  "weight",      default: 0
  end

  create_table "events_users", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "events_users", ["event_id"], name: "index_events_users_on_event_id"
  add_index "events_users", ["user_id"], name: "index_events_users_on_user_id"

  create_table "photos", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "name"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_classifies", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "question_classify_id"
    t.string   "a"
    t.string   "b"
    t.string   "c"
    t.string   "d"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "taxons", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "parent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.string   "hobby"
    t.string   "weixin_id"
  end

  add_index "users", ["email", "password"], name: "index_users_on_email_and_password"

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
