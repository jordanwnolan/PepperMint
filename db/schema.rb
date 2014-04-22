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

ActiveRecord::Schema.define(version: 20140422115058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.integer  "user_id",          null: false
    t.integer  "bank_id",          null: false
    t.string   "account_username"
    t.string   "account_password"
    t.string   "account_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "balance"
    t.integer  "account_type"
  end

  add_index "accounts", ["bank_id"], name: "index_accounts_on_bank_id", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "banks", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banks", ["name"], name: "index_banks_on_name", using: :btree

  create_table "merchant_categories", force: true do |t|
    t.integer  "merchant_category_code"
    t.string   "merchant_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.integer  "age"
    t.integer  "gender"
    t.integer  "zip_code"
    t.string   "secondary_email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "account_id"
    t.integer  "merchant_category_code"
    t.text     "description"
    t.string   "category"
    t.integer  "amount"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "session_token"
    t.string   "picture_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
