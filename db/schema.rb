# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_12_17_094433) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cryptocurrencies", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "name", null: false
    t.decimal "current_price", precision: 20, scale: 8, null: false
    t.decimal "market_cap", precision: 20, scale: 2
    t.decimal "volume_24h", precision: 20, scale: 2
    t.decimal "price_change_24h", precision: 20, scale: 8
    t.decimal "price_change_percentage_24h", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_cap"], name: "index_cryptocurrencies_on_market_cap"
    t.index ["symbol"], name: "index_cryptocurrencies_on_symbol", unique: true
  end

  create_table "portfolio_items", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.bigint "cryptocurrency_id", null: false
    t.decimal "quantity", precision: 20, scale: 8, null: false
    t.decimal "average_price", precision: 20, scale: 8, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cryptocurrency_id"], name: "index_portfolio_items_on_cryptocurrency_id"
    t.index ["portfolio_id", "cryptocurrency_id"], name: "index_portfolio_items_on_portfolio_id_and_cryptocurrency_id", unique: true
    t.index ["portfolio_id"], name: "index_portfolio_items_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "total_value", precision: 20, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id", unique: true
  end

  create_table "price_alerts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cryptocurrency_id", null: false
    t.decimal "target_price", precision: 20, scale: 8
    t.string "alert_type", default: "above"
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cryptocurrency_id"], name: "index_price_alerts_on_cryptocurrency_id"
    t.index ["user_id"], name: "index_price_alerts_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cryptocurrency_id", null: false
    t.string "transaction_type", null: false
    t.decimal "quantity", precision: 20, scale: 8, null: false
    t.decimal "price", precision: 20, scale: 8, null: false
    t.decimal "total_amount", precision: 20, scale: 8, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cryptocurrency_id"], name: "index_transactions_on_cryptocurrency_id"
    t.index ["user_id", "created_at"], name: "index_transactions_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "portfolio_items", "cryptocurrencies"
  add_foreign_key "portfolio_items", "portfolios"
  add_foreign_key "portfolios", "users"
  add_foreign_key "price_alerts", "cryptocurrencies"
  add_foreign_key "price_alerts", "users"
  add_foreign_key "transactions", "cryptocurrencies"
  add_foreign_key "transactions", "users"
end
