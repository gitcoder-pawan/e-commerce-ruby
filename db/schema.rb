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

ActiveRecord::Schema[7.1].define(version: 2023_11_17_165652) do
  create_table "accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "gender"
    t.integer "contact_number"
    t.string "email"
    t.string "password"
    t.boolean "activated"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "activation_code"
    t.integer "password_code"
    t.integer "token_version", default: 0
  end

  create_table "addresses", force: :cascade do |t|
    t.string "area"
    t.string "post_office"
    t.string "police_station"
    t.string "city"
    t.string "state"
    t.string "country"
    t.integer "pin_code"
    t.string "landmark"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_addresses_on_account_id"
  end

  create_table "order_supplier_products", force: :cascade do |t|
    t.integer "order_id"
    t.integer "supplier_product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_supplier_products_on_order_id"
    t.index ["supplier_product_id"], name: "index_order_supplier_products_on_supplier_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "account_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_amount"
    t.index ["account_id"], name: "index_orders_on_account_id"
  end

  create_table "product_complaints", force: :cascade do |t|
    t.string "complaint"
    t.integer "account_id"
    t.integer "supplier_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_product_complaints_on_account_id"
    t.index ["supplier_product_id"], name: "index_product_complaints_on_supplier_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "length", default: 0
    t.integer "breadth", default: 0
    t.integer "height", default: 0
    t.integer "weight", default: 0
    t.string "category"
    t.string "sub_category"
    t.string "status"
  end

  create_table "rating_feedbacks", force: :cascade do |t|
    t.integer "rating"
    t.string "feedback"
    t.integer "account_id"
    t.integer "supplier_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_rating_feedbacks_on_account_id"
    t.index ["supplier_product_id"], name: "index_rating_feedbacks_on_supplier_product_id"
  end

  create_table "supplier_accounts", force: :cascade do |t|
    t.string "aadhar_number"
    t.boolean "verified"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_supplier_accounts_on_account_id"
  end

  create_table "supplier_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "supplier_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price"
    t.string "color"
    t.string "brand"
    t.integer "quantity", default: 0
    t.index ["product_id"], name: "index_supplier_products_on_product_id"
    t.index ["supplier_account_id"], name: "index_supplier_products_on_supplier_account_id"
  end

  add_foreign_key "addresses", "accounts"
end
