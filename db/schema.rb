# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150603232952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_tools", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "tool_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categories_tools", ["category_id"], name: "index_categories_tools_on_category_id", using: :btree
  add_index "categories_tools", ["tool_id"], name: "index_categories_tools_on_tool_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.text     "post"
    t.integer  "rating"
    t.integer  "tool_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["tool_id"], name: "index_reviews_on_tool_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_tools", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags_tools", ["tag_id"], name: "index_tags_tools_on_tag_id", using: :btree
  add_index "tags_tools", ["tool_id"], name: "index_tags_tools_on_tool_id", using: :btree

  create_table "tools", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "language"
    t.integer  "is_free"
    t.string   "web_url"
    t.string   "repo_url"
    t.integer  "avg_rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "doc_url"
    t.boolean  "is_open"
  end

  create_table "tools_users", force: :cascade do |t|
    t.integer  "tool_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tools_users", ["tool_id"], name: "index_tools_users_on_tool_id", using: :btree
  add_index "tools_users", ["user_id"], name: "index_tools_users_on_user_id", using: :btree

  create_table "tvotes", force: :cascade do |t|
    t.integer  "vote"
    t.integer  "tool_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tvotes", ["tool_id"], name: "index_tvotes_on_tool_id", using: :btree
  add_index "tvotes", ["user_id"], name: "index_tvotes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "image_url"
    t.string   "provider"
    t.string   "provider_id"
    t.string   "provider_hash"
    t.string   "refresh_hash"
    t.datetime "hash_expires_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "role"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "categories_tools", "categories"
  add_foreign_key "categories_tools", "tools"
  add_foreign_key "reviews", "tools"
  add_foreign_key "reviews", "users"
  add_foreign_key "tags_tools", "tags"
  add_foreign_key "tags_tools", "tools"
  add_foreign_key "tools_users", "tools"
  add_foreign_key "tools_users", "users"
  add_foreign_key "tvotes", "tools"
  add_foreign_key "tvotes", "users"
end
