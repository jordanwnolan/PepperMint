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

ActiveRecord::Schema.define(version: 20140424044431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.integer  "user_id",                      null: false
    t.integer  "bank_id",                      null: false
    t.string   "account_username"
    t.string   "account_password"
    t.string   "account_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "balance",          default: 0
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

  create_table "budgets", force: true do |t|
    t.integer  "user_id",                        null: false
    t.integer  "category_id",                    null: false
    t.integer  "frequency",                      null: false
    t.integer  "frequency_reset"
    t.integer  "amount",                         null: false
    t.boolean  "private",         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",       default: true
  end

  add_index "budgets", ["category_id"], name: "index_budgets_on_category_id", using: :btree
  add_index "budgets", ["user_id"], name: "index_budgets_on_user_id", using: :btree

  create_table "fames", force: true do |t|
    t.integer  "value"
    t.integer  "user_giving_fame_id"
    t.integer  "user_receiving_fame_id"
    t.integer  "fameable_id"
    t.string   "fameable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "share_id"
  end

  add_index "fames", ["user_giving_fame_id"], name: "index_fames_on_user_giving_fame_id", using: :btree
  add_index "fames", ["user_receiving_fame_id"], name: "index_fames_on_user_receiving_fame_id", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followed_id"], name: "index_follows_on_followed_id", using: :btree
  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id", using: :btree

  create_table "goals", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "account_id"
    t.integer  "account_initial_bal", default: 0
    t.date     "goal_date"
    t.integer  "amount"
    t.boolean  "private",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "monthly_amount"
    t.boolean  "is_active",           default: true
  end

  add_index "goals", ["account_id"], name: "index_goals_on_account_id", using: :btree
  add_index "goals", ["user_id"], name: "index_goals_on_user_id", using: :btree

  create_table "merchant_categories", force: true do |t|
    t.integer  "merchant_category_code"
    t.string   "merchant_category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "transaction_category_id"
  end

  add_index "merchant_categories", ["transaction_category_id"], name: "index_merchant_categories_on_transaction_category_id", using: :btree

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

  create_table "shares", force: true do |t|
    t.text     "message"
    t.boolean  "status"
    t.integer  "shareable_id"
    t.string   "shareable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shares", ["user_id"], name: "index_shares_on_user_id", using: :btree

  create_table "transaction_categories", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "account_id"
    t.integer  "merchant_category_code"
    t.text     "description"
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
