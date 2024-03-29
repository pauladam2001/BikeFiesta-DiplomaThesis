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

ActiveRecord::Schema.define(version: 2023_04_03_195917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assets", force: :cascade do |t|
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.boolean "is_bicycle", default: false
  end

  create_table "brandnames", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_brandnames_on_name", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_colors_on_name", unique: true
  end

  create_table "component_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_component_groups_on_name", unique: true
  end

  create_table "costs", force: :cascade do |t|
    t.float "amount"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "day"
    t.index ["amount", "description"], name: "index_costs_on_amount_and_description", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "short"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_materials_on_name", unique: true
  end

  create_table "message_statuses", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_message_statuses_on_message_id"
    t.index ["room_id"], name: "index_message_statuses_on_room_id"
    t.index ["user_id"], name: "index_message_statuses_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "post_id"
    t.integer "notified_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "message"
    t.string "notification_type"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "last_read_at"
    t.index ["room_id"], name: "index_participants_on_room_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "price"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "views", default: 0
    t.text "short_description"
    t.integer "year"
    t.float "sale_price"
    t.datetime "sale_price_expiration"
    t.integer "color_id"
    t.integer "location_id"
    t.integer "brandname_id"
    t.integer "is_active", default: 0
    t.string "size"
    t.integer "category_id"
    t.integer "material_id"
    t.string "condition"
    t.integer "component_group_id"
    t.boolean "electric"
    t.boolean "sold", default: false
    t.integer "buyer_id"
    t.datetime "sold_date"
    t.boolean "leave_review_notification_sent", default: false
    t.boolean "shipped", default: false
    t.float "sale_percentage"
    t.datetime "shipped_date"
    t.index ["buyer_id"], name: "index_posts_on_buyer_id"
    t.index ["is_active", "user_id"], name: "index_posts_on_is_active_and_user_id"
    t.index ["is_active"], name: "index_posts_on_is_active"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "seller_id"
    t.integer "buyer_id"
    t.integer "post_id"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.text "shipping_details"
    t.text "payment_details"
    t.boolean "on_hold", default: false
    t.boolean "money_sent_to_seller", default: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.text "message"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "solved", default: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "reviewer_id"
    t.integer "reviewed_id"
    t.text "message"
    t.integer "grade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.boolean "is_private"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stats", force: :cascade do |t|
    t.datetime "analysis_start_time"
    t.datetime "analysis_end_time"
    t.date "end_date"
    t.float "total_revenue"
    t.float "total_spent"
    t.float "total_profit"
    t.float "roi"
    t.integer "total_views"
    t.integer "total_posts"
    t.integer "total_transactions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "period"
    t.integer "validating_posts"
    t.integer "banned_posts"
    t.integer "active_posts"
    t.integer "sold_not_shipped_posts"
    t.integer "sold_shipped_posts"
    t.integer "user_id"
    t.integer "user_views"
    t.integer "followers"
    t.integer "following"
    t.integer "user_posts"
    t.float "user_revenue"
    t.float "user_spent"
    t.index ["end_date", "period"], name: "stats_common_query"
  end

  create_table "suggestions", force: :cascade do |t|
    t.integer "user_id"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "solved", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "uid"
    t.string "avatar_url"
    t.string "role", default: "normal"
    t.string "provider"
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "code"
    t.string "phone"
    t.datetime "code_expiration_date"
    t.boolean "archived", default: false
    t.float "rating"
    t.string "paypal_email"
    t.float "discount"
    t.boolean "sms_opt_in", default: false
    t.boolean "showed_rules", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "message_statuses", "messages"
  add_foreign_key "message_statuses", "rooms"
  add_foreign_key "message_statuses", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "participants", "rooms"
  add_foreign_key "participants", "users"
end
