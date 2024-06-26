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

ActiveRecord::Schema[7.1].define(version: 2024_05_17_023105) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "buffets", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "district"
    t.string "state"
    t.string "city"
    t.string "zip_code"
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
    t.index ["user_id"], name: "index_buffets_on_user_id"
  end

  create_table "event_prices", force: :cascade do |t|
    t.integer "event_type_id", null: false
    t.decimal "base_price"
    t.decimal "additional_guest_price"
    t.decimal "extra_hour_price"
    t.boolean "price_for_weekend", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type_id"], name: "index_event_prices_on_event_type_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.string "name"
    t.text "description"
    t.integer "min_guests"
    t.integer "max_guests"
    t.integer "duration_minutes"
    t.text "menu_description"
    t.boolean "alcohol_included", default: false
    t.boolean "decoration_included", default: false
    t.boolean "parking_available", default: false
    t.string "location_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
    t.index ["buffet_id"], name: "index_event_types_on_buffet_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_messages_on_order_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "order_budgets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "buffet_id", null: false
    t.integer "order_id", null: false
    t.decimal "final_price"
    t.date "valid_until"
    t.decimal "extra_fee"
    t.decimal "discount"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_method_id", null: false
    t.index ["buffet_id"], name: "index_order_budgets_on_buffet_id"
    t.index ["order_id"], name: "index_order_budgets_on_order_id"
    t.index ["payment_method_id"], name: "index_order_budgets_on_payment_method_id"
    t.index ["user_id"], name: "index_order_budgets_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.integer "user_id", null: false
    t.integer "event_type_id", null: false
    t.integer "number_of_guests"
    t.date "event_date"
    t.string "address"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "details"
    t.string "code"
    t.integer "payment_method_id", null: false
    t.index ["buffet_id"], name: "index_orders_on_buffet_id"
    t.index ["event_type_id"], name: "index_orders_on_event_type_id"
    t.index ["payment_method_id"], name: "index_orders_on_payment_method_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_method_buffets", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_payment_method_buffets_on_buffet_id"
    t.index ["payment_method_id"], name: "index_payment_method_buffets_on_payment_method_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.integer "buffet_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_reviews_on_buffet_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "is_buffet_owner", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "cpf"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "buffets", "users"
  add_foreign_key "event_prices", "event_types"
  add_foreign_key "event_types", "buffets"
  add_foreign_key "messages", "orders"
  add_foreign_key "messages", "users"
  add_foreign_key "order_budgets", "buffets"
  add_foreign_key "order_budgets", "orders"
  add_foreign_key "order_budgets", "payment_methods"
  add_foreign_key "order_budgets", "users"
  add_foreign_key "orders", "buffets"
  add_foreign_key "orders", "event_types"
  add_foreign_key "orders", "payment_methods"
  add_foreign_key "orders", "users"
  add_foreign_key "payment_method_buffets", "buffets"
  add_foreign_key "payment_method_buffets", "payment_methods"
  add_foreign_key "reviews", "buffets"
  add_foreign_key "reviews", "users"
end
