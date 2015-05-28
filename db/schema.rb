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

ActiveRecord::Schema.define(version: 20150528160744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "avatar_pictures", force: :cascade do |t|
    t.string   "uri"
    t.string   "caption"
    t.integer  "avatar_crop_x"
    t.integer  "avatar_crop_y"
    t.integer  "avatar_crop_w"
    t.integer  "avatar_crop_h"
    t.string   "avatarable_type"
    t.integer  "avatarable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

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

  create_table "charges", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "balance_transaction_id"
    t.string   "kind"
    t.integer  "amount_cents",           default: 0,     null: false
    t.string   "amount_currency",        default: "USD", null: false
    t.integer  "total_fee_cents",        default: 0,     null: false
    t.string   "total_fee_currency",     default: "USD", null: false
    t.boolean  "paid"
    t.boolean  "captured"
    t.json     "fee_details"
    t.string   "chargeable_type"
    t.integer  "chargeable_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "charges", ["balance_transaction_id"], name: "index_charges_on_balance_transaction_id", unique: true, using: :btree
  add_index "charges", ["stripe_id"], name: "index_charges_on_stripe_id", unique: true, using: :btree

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
    t.string   "visitor_url"
    t.string   "visitor_action"
    t.integer  "fee_percentage",          default: 17
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
    t.string   "phone"
    t.string   "sponsor_url"
    t.string   "multiple_locations"
    t.boolean  "universal",                   default: false
    t.string   "status",                      default: "incomplete"
    t.text     "custom_terms"
    t.integer  "merchandise_categories_mask"
    t.integer  "price_cents",                 default: 0,            null: false
    t.string   "price_currency",              default: "USD",        null: false
    t.string   "sponsor_name"
    t.integer  "collection_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.string   "country_code"
    t.string   "state_code"
    t.string   "zip_code"
    t.string   "city"
    t.string   "locatable_type"
    t.integer  "locatable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
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

  create_table "pr_boxes", force: :cascade do |t|
    t.string   "headline"
    t.text     "story"
    t.string   "url"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "email"
    t.string   "card_token"
    t.integer  "amount_cents",     default: 0,     null: false
    t.string   "amount_currency",  default: "USD", null: false
    t.string   "purchasable_type"
    t.integer  "purchasable_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "subscriptors", force: :cascade do |t|
    t.string   "email"
    t.string   "object_type"
    t.integer  "object_id"
    t.string   "phone"
    t.string   "organization"
    t.text     "message"
    t.string   "name"
    t.string   "origin_type"
    t.integer  "origin_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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
