# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_06_084338) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "basket_suborders", force: :cascade do |t|
    t.integer "meal_id", null: false
    t.integer "basket_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["basket_id"], name: "index_basket_suborders_on_basket_id"
    t.index ["meal_id"], name: "index_basket_suborders_on_meal_id"
  end

  create_table "baskets", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "cook_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rank"
    t.index ["cook_id"], name: "index_categories_on_cook_id"
  end

  create_table "cooks", force: :cascade do |t|
    t.integer "user_id"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["user_id"], name: "index_cooks_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "meal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rank"
    t.index ["meal_id"], name: "index_ingredients_on_meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "category_id"
    t.float "price"
    t.string "name"
    t.boolean "deleted"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "information"
    t.integer "rank"
    t.integer "cook_id"
    t.index ["category_id"], name: "index_meals_on_category_id"
    t.index ["cook_id"], name: "index_meals_on_cook_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "cook_id", null: false
    t.integer "customer_id", null: false
    t.string "status"
    t.float "total_price"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "instructions"
    t.boolean "cgu_validation"
    t.boolean "customer_validation"
    t.boolean "cook_validation"
    t.index ["cook_id"], name: "index_orders_on_cook_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "suborders", force: :cascade do |t|
    t.integer "meal_id", null: false
    t.integer "order_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meal_id"], name: "index_suborders_on_meal_id"
    t.index ["order_id"], name: "index_suborders_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "zip"
    t.string "city"
    t.string "phone_number"
    t.boolean "admin"
    t.string "flat_number"
    t.string "digicode"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "basket_suborders", "baskets"
  add_foreign_key "basket_suborders", "meals"
  add_foreign_key "categories", "cooks"
  add_foreign_key "cooks", "users"
  add_foreign_key "ingredients", "meals"
  add_foreign_key "meals", "categories"
  add_foreign_key "meals", "cooks"
  add_foreign_key "orders", "cooks"
  add_foreign_key "orders", "users", column: "customer_id"
  add_foreign_key "suborders", "meals"
  add_foreign_key "suborders", "orders"
end
