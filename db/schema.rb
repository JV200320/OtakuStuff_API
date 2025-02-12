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

ActiveRecord::Schema.define(version: 2021_10_03_145259) do

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

  create_table "anime_likes", force: :cascade do |t|
    t.bigint "anime_post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["anime_post_id"], name: "index_anime_likes_on_anime_post_id"
    t.index ["user_id"], name: "index_anime_likes_on_user_id"
  end

  create_table "anime_posts", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.integer "anime_id"
    t.integer "kind", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_nickname"
    t.string "user_image_url"
    t.index ["user_id"], name: "index_anime_posts_on_user_id"
  end

  create_table "anime_replies", force: :cascade do |t|
    t.integer "comment_id"
    t.integer "reply_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "page_likes", force: :cascade do |t|
    t.bigint "page_post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_post_id"], name: "index_page_likes_on_page_post_id"
    t.index ["user_id"], name: "index_page_likes_on_user_id"
  end

  create_table "page_posts", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.text "content"
    t.bigint "user_id", null: false
    t.integer "kind", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_page_posts_on_page_id"
    t.index ["user_id"], name: "index_page_posts_on_user_id"
  end

  create_table "page_relationships", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_page_relationships_on_page_id"
    t.index ["user_id"], name: "index_page_relationships_on_user_id"
  end

  create_table "page_replies", force: :cascade do |t|
    t.integer "comment_id"
    t.integer "reply_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "image"
    t.string "title"
    t.text "description", default: "Ainda não temos uma descrição."
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "owner_nickname"
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "favorites", default: [], array: true
    t.text "bio", default: "Ainda não tenho uma bio."
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "anime_likes", "anime_posts"
  add_foreign_key "anime_likes", "users"
  add_foreign_key "anime_posts", "users"
  add_foreign_key "page_likes", "page_posts"
  add_foreign_key "page_likes", "users"
  add_foreign_key "page_posts", "pages"
  add_foreign_key "page_posts", "users"
  add_foreign_key "page_relationships", "pages"
  add_foreign_key "page_relationships", "users"
  add_foreign_key "pages", "users"
end
