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

ActiveRecord::Schema.define(version: 2019_11_26_143956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entrepreneurs", force: :cascade do |t|
    t.string "prismic_id"
    t.string "name"
    t.string "position"
    t.string "description"
    t.string "picture_url"
    t.string "picture_alt"
    t.bigint "project_id"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_entrepreneurs_on_project_id"
  end

  create_table "highlighted_contents", force: :cascade do |t|
    t.string "prismic_id"
    t.boolean "published", default: false
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_highlighted_contents_on_project_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "sender_first_name"
    t.string "sender_last_name"
    t.string "sender_email"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sender_phone"
    t.boolean "interested_to_invest", default: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "prismic_id"
    t.string "slug"
    t.string "title"
    t.string "meta_title"
    t.string "meta_description"
    t.string "project_url"
    t.string "funding_status"
    t.string "long_summary"
    t.string "short_summary"
    t.text "description"
    t.string "quote"
    t.string "cover_image_url"
    t.string "cover_image_alt"
    t.string "secondary_image_1_url"
    t.string "secondary_image_1_alt"
    t.string "secondary_image_2_url"
    t.string "secondary_image_2_alt"
    t.string "project_logo_url"
    t.string "project_logo_alt"
    t.string "keyword_1"
    t.string "icon_1"
    t.string "keyword_2"
    t.string "icon_2"
    t.string "keyword_3"
    t.string "icon_3"
    t.string "keyword_4"
    t.string "icon_4"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "highlighted_contents", "projects"
end
