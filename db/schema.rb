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

ActiveRecord::Schema[7.0].define(version: 2022_04_28_001743) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "commentable_type"
    t.integer "commentable_id"
    t.text "body_text", null: false
    t.text "body_json", null: false
    t.bigint "parent_id"
    t.datetime "body_updated_at"
    t.string "slug", null: false
    t.integer "liked_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["slug"], name: "index_comments_on_slug", unique: true
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "follow_relationships", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_follow_relationships_on_follower_id"
    t.index ["following_id"], name: "index_follow_relationships_on_following_id"
  end

  create_table "likes", force: :cascade do |t|
    t.boolean "liked", default: false, null: false
    t.bigint "user_id", null: false
    t.string "likable_type", null: false
    t.bigint "likable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "space_id"
    t.bigint "user_id"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id", "user_id"], name: "index_memberships_on_space_id_and_user_id", unique: true
    t.index ["space_id"], name: "index_memberships_on_space_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.text "body_text"
    t.text "body_json"
    t.string "slug", null: false
    t.datetime "body_updated_at"
    t.datetime "posted_at"
    t.datetime "last_comment_created_at"
    t.integer "comments_count", default: 0, null: false
    t.integer "liked_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "space_id", null: false
    t.index ["slug"], name: "index_notes_on_slug", unique: true
    t.index ["space_id"], name: "index_notes_on_space_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "recipient_id", null: false
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.bigint "sender_id"
    t.string "action", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "name", null: false
    t.string "emoji", null: false
    t.string "slug", null: false
    t.boolean "archived", default: false, null: false
    t.boolean "favorite", default: false, null: false
    t.datetime "archived_at"
    t.integer "notes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_spaces_on_owner_id"
    t.index ["slug"], name: "index_spaces_on_slug", unique: true
  end

  create_table "talks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.string "slug", null: false
    t.boolean "archived", default: false, null: false
    t.boolean "closed", default: false, null: false
    t.datetime "closed_at"
    t.datetime "last_comment_created_at"
    t.integer "comments_count", default: 0, null: false
    t.integer "liked_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_talks_on_slug", unique: true
    t.index ["user_id"], name: "index_talks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "twitter_username"
    t.string "unconfirmed_email"
    t.text "bio"
    t.integer "notifications_count", default: 0, null: false
    t.integer "follower_count", default: 0, null: false
    t.integer "following_count", default: 0, null: false
    t.integer "role", default: 0, null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "activated_at"
    t.datetime "locked_at"
    t.boolean "email_notify_comments", default: true, null: false
    t.boolean "email_notify_followings", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "follow_relationships", "users", column: "follower_id"
  add_foreign_key "follow_relationships", "users", column: "following_id"
  add_foreign_key "likes", "users"
  add_foreign_key "memberships", "spaces"
  add_foreign_key "memberships", "users"
  add_foreign_key "notes", "spaces"
  add_foreign_key "notes", "users"
  add_foreign_key "notifications", "users", column: "recipient_id"
  add_foreign_key "spaces", "users", column: "owner_id"
  add_foreign_key "talks", "users"
end
