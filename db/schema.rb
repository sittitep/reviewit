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

ActiveRecord::Schema.define(version: 2020_02_06_144032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "text"
    t.uuid "post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "vote_count", default: 0
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contributors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "branch_id", null: false
    t.integer "points", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["branch_id"], name: "index_contributors_on_branch_id"
    t.index ["user_id"], name: "index_contributors_on_user_id"
  end

  create_table "moderators", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "branch_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["branch_id"], name: "index_moderators_on_branch_id"
    t.index ["user_id"], name: "index_moderators_on_user_id"
  end

  create_table "posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "vote_count", default: 0
    t.integer "comment_count", default: 0
    t.datetime "resolved_at"
    t.datetime "closed_at"
    t.datetime "deleted_at"
    t.bigint "branch_id", null: false
    t.index ["branch_id"], name: "index_posts_on_branch_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "avatar_url"
    t.string "github_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_url"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "originator_type"
    t.uuid "originator_id"
    t.index ["originator_type", "originator_id"], name: "index_votes_on_originator_type_and_originator_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "contributors", "branches"
  add_foreign_key "contributors", "users"
  add_foreign_key "moderators", "branches"
  add_foreign_key "moderators", "users"
  add_foreign_key "posts", "branches"
  add_foreign_key "posts", "users"
  add_foreign_key "votes", "users"
end
