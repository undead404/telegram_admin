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

ActiveRecord::Schema.define(version: 2020_12_01_104903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bots", force: :cascade do |t|
    t.string "encrypted_token"
    t.string "encrypted_token_iv"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "f", null: false
    t.bigint "owner_id"
    t.boolean "confirmed", default: false, null: false
    t.index ["owner_id"], name: "index_bots_on_owner_id"
  end

  create_table "bots_chats", id: false, force: :cascade do |t|
    t.bigint "bot_id", null: false
    t.bigint "chat_id", null: false
    t.index ["bot_id"], name: "index_bots_chats_on_bot_id"
    t.index ["chat_id"], name: "index_bots_chats_on_chat_id"
  end

  create_table "bots_users", id: false, force: :cascade do |t|
    t.bigint "bot_id", null: false
    t.bigint "user_id", null: false
    t.index ["bot_id"], name: "index_bots_users_on_bot_id"
    t.index ["user_id"], name: "index_bots_users_on_user_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chats_users", id: false, force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.bigint "user_id", null: false
    t.index ["chat_id"], name: "index_chats_users_on_chat_id"
    t.index ["user_id"], name: "index_chats_users_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "text", null: false
    t.string "parse_mode", default: "Plain text"
    t.datetime "sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "chat_id", null: false
    t.integer "message_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.bigint "author_id"
    t.index ["author_id"], name: "index_messages_on_author_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bots", "users", column: "owner_id"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users", column: "author_id"
end
