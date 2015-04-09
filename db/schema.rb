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

ActiveRecord::Schema.define(version: 20150409183044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupon_books", force: :cascade do |t|
    t.integer  "coupon_book_campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupon_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "coupon_book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", force: :cascade do |t|
    t.integer  "position"
    t.string   "title"
    t.datetime "expires_at"
    t.text     "description"
    t.string   "promo_code"
    t.text     "terms_and_conditions"
    t.string   "url"
    t.integer  "coupon_categories_mask", limit: 8
    t.integer  "coupon_book_id"
    t.integer  "coupon_category_id"
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

end
