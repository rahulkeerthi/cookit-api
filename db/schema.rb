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

ActiveRecord::Schema.define(version: 2020_06_11_160643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kit_tags", force: :cascade do |t|
    t.bigint "kit_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["kit_id"], name: "index_kit_tags_on_kit_id"
    t.index ["tag_id"], name: "index_kit_tags_on_tag_id"
  end

  create_table "kits", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "ingredients"
    t.string "link_url"
    t.float "price"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_kits_on_restaurant_id"
  end

  create_table "restaurant_tags", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_restaurant_tags_on_restaurant_id"
    t.index ["tag_id"], name: "index_restaurant_tags_on_tag_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.float "map_lat"
    t.float "map_long"
    t.string "city"
    t.string "postcode"
    t.string "address1"
    t.string "address2"
    t.text "description"
    t.string "delivery_options"
    t.string "email"
    t.string "twitter"
    t.string "facebook"
    t.string "instagram"
    t.string "website_url"
    t.string "contact_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_restaurants", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_user_restaurants_on_restaurant_id"
    t.index ["user_id"], name: "index_user_restaurants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "kit_tags", "kits"
  add_foreign_key "kit_tags", "tags"
  add_foreign_key "kits", "restaurants"
  add_foreign_key "restaurant_tags", "restaurants"
  add_foreign_key "restaurant_tags", "tags"
  add_foreign_key "user_restaurants", "restaurants"
  add_foreign_key "user_restaurants", "users"
end
