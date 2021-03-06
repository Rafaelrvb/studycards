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

ActiveRecord::Schema.define(version: 2021_09_08_203454) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.text "front_page"
    t.text "back_page"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_id"], name: "index_cards_on_deck_id"
  end

  create_table "deck_communities", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_id"], name: "index_deck_communities_on_deck_id"
    t.index ["user_id"], name: "index_deck_communities_on_user_id"
  end

  create_table "deck_reviews", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.bigint "user_id", null: false
    t.text "review_content"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_id"], name: "index_deck_reviews_on_deck_id"
    t.index ["user_id"], name: "index_deck_reviews_on_user_id"
  end

  create_table "decks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "availability", default: "Public"
    t.integer "price_cents", default: 0, null: false
    t.string "sku"
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.string "deck_sku"
    t.integer "amount_cents", default: 0, null: false
    t.string "checkout_session_id"
    t.bigint "user_id", null: false
    t.bigint "deck_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_id"], name: "index_orders_on_deck_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "studies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "card_id"
    t.integer "repetition", default: 1
    t.float "grade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_studies_on_user_id"
  end

  create_table "user_progresses", force: :cascade do |t|
    t.bigint "deck_community_id", null: false
    t.integer "sessions"
    t.integer "cards_per_session"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_community_id"], name: "index_user_progresses_on_deck_community_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cards", "decks"
  add_foreign_key "deck_communities", "decks"
  add_foreign_key "deck_communities", "users"
  add_foreign_key "deck_reviews", "decks"
  add_foreign_key "deck_reviews", "users"
  add_foreign_key "decks", "users"
  add_foreign_key "orders", "decks"
  add_foreign_key "orders", "users"
  add_foreign_key "studies", "users"
  add_foreign_key "user_progresses", "deck_communities"
end
