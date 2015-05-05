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

ActiveRecord::Schema.define(version: 20150505191835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "coupon_book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_coupons", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "coupon_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: :cascade do |t|
    t.integer "owner_id"
    t.string  "owner_type"
  end

  create_table "collections_coupons", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "coupon_id"
    t.integer "position"
  end

  create_table "coupon_books", force: :cascade do |t|
    t.integer  "coupon_book_campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fundraiser_id"
    t.string   "name"
    t.datetime "launch_date"
    t.datetime "end_date"
    t.string   "url"
    t.string   "headline"
    t.text     "story"
    t.string   "status",                  default: "incomplete"
    t.text     "mission"
    t.boolean  "visible",                 default: false
    t.integer  "goal_cents",              default: 0,            null: false
    t.string   "goal_currency",           default: "USD",        null: false
    t.integer  "price_cents",             default: 0,            null: false
    t.string   "price_currency",          default: "USD",        null: false
    t.integer  "causes_mask"
    t.integer  "scopes_mask"
    t.string   "main_cause"
  end

  create_table "coupons", force: :cascade do |t|
    t.integer  "position"
    t.string   "title"
    t.datetime "expires_at"
    t.text     "description"
    t.string   "promo_code"
    t.text     "terms_and_conditions"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "avatar"
    t.string   "avatar_caption"
    t.string   "banner"
    t.string   "banner_caption"
    t.string   "picturable_type"
    t.integer  "picturable_id"
    t.integer  "avatar_crop_x"
    t.integer  "avatar_crop_y"
    t.integer  "avatar_crop_w"
    t.integer  "avatar_crop_h"
    t.integer  "banner_crop_x"
    t.integer  "banner_crop_y"
    t.integer  "banner_crop_w"
    t.integer  "banner_crop_h"
    t.string   "qrcode"
    t.integer  "qrcode_crop_x"
    t.integer  "qrcode_crop_y"
    t.integer  "qrcode_crop_w"
    t.integer  "qrcode_crop_h"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: :cascade do |t|
    t.string  "recordable_type"
    t.integer "recordable_id"
    t.string  "url"
    t.string  "provider"
    t.string  "thumbnail"
    t.boolean "auto_show",       default: false
  end

end
