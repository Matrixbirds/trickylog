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

ActiveRecord::Schema.define(version: 20160310132348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "articles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",                        null: false
    t.string   "description"
    t.uuid     "author_id",                    null: false
    t.text     "content",                      null: false
    t.string   "comments_count", default: "0", null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "status",         default: 0,   null: false
  end

  create_table "comments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",                  null: false
    t.string   "content"
    t.uuid     "author_id",              null: false
    t.uuid     "article_id",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0, null: false
  end

  create_table "identities", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.uuid   "user_id"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "messages", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "user_name"
    t.string   "user_avatar"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "tech_source_url_id", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "description"
    t.string   "source_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technews", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "url"
    t.string   "provider"
    t.uuid     "tech_source_url_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "encrypted_passwd",             null: false
    t.integer  "gender"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "status",           default: 0, null: false
  end

  add_foreign_key "articles", "users", column: "author_id"
  add_foreign_key "comments", "users", column: "author_id"
end
