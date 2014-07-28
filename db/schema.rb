# coding: utf-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140605062510) do

  create_table "applies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "name"
    t.string   "email"
    t.integer  "age"
    t.string   "sex"
    t.integer  "approved",   :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "articles", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
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
    t.integer  "approved",    :default => 0
    t.text     "content"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "sex"
    t.string   "mobile"
    t.string   "logo"
    t.string   "position"
    t.integer  "age"
    t.string   "qq"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["email", "password"], :name => "index_users_on_email_and_password"

end
