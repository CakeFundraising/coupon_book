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

ActiveRecord::Schema.define(version: 20151007191915) do

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

  create_table "affiliate_campaigns", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "url"
    t.string   "organization_name"
    t.text     "story"
    t.string   "slug"
    t.string   "screenshot_url"
    t.string   "screenshot_version"
    t.boolean  "use_stripe",            default: false
    t.string   "check_recipient_name"
    t.integer  "affiliate_id"
    t.integer  "community_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "commission_percentage", default: 0
  end

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

  create_table "browsers", force: :cascade do |t|
    t.string   "token"
    t.string   "fingerprint"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "browsers", ["fingerprint"], name: "index_browsers_on_fingerprint", using: :btree
  add_index "browsers", ["token"], name: "index_browsers_on_token", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "coupon_book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "coupons_count"
    t.string   "subtitle"
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
    t.integer "coupons_count"
  end

  create_table "collections_coupons", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "coupon_id"
    t.integer "position"
  end

  create_table "commissions", force: :cascade do |t|
    t.integer  "amount_cents",        default: 0,     null: false
    t.string   "amount_currency",     default: "USD", null: false
    t.integer  "percentage"
    t.integer  "purchase_id"
    t.integer  "commissionable_id"
    t.string   "commissionable_type"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "paid",                default: false
    t.integer  "transfer_id"
  end

  add_index "commissions", ["commissionable_type", "commissionable_id"], name: "index_commissions_on_commissionable_type_and_commissionable_id", using: :btree

  create_table "communities", force: :cascade do |t|
    t.string   "slug"
    t.integer  "coupon_book_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "media_commission_percentage",     default: 0
    t.integer  "affiliate_commission_percentage", default: 0
    t.string   "screenshot_url"
    t.string   "screenshot_version"
  end

  create_table "coupon_books", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fundraiser_id"
    t.string   "name"
    t.datetime "launch_date"
    t.datetime "end_date"
    t.string   "url"
    t.string   "headline"
    t.text     "story"
    t.string   "status",                       default: "incomplete"
    t.text     "mission"
    t.boolean  "visible",                      default: false
    t.string   "goal_currency",                default: "USD",        null: false
    t.integer  "price_cents",                  default: 0,            null: false
    t.string   "price_currency",               default: "USD",        null: false
    t.string   "main_cause"
    t.string   "visitor_url"
    t.string   "visitor_action"
    t.float    "fee_percentage",               default: 16.25
    t.string   "organization_name"
    t.string   "screenshot_url"
    t.string   "screenshot_version"
    t.string   "template",                     default: "commercial"
    t.string   "slug"
    t.string   "bottom_tagline"
    t.string   "title"
    t.integer  "goal_cents",         limit: 8, default: 0,            null: false
    t.integer  "causes_mask",        limit: 8
    t.integer  "scopes_mask",        limit: 8
  end

  add_index "coupon_books", ["slug"], name: "index_coupon_books_on_slug", unique: true, using: :btree

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
    t.text     "multiple_locations"
    t.boolean  "universal",                             default: false
    t.string   "status",                                default: "incomplete"
    t.text     "custom_terms"
    t.integer  "price_cents",                           default: 0,            null: false
    t.string   "price_currency",                        default: "USD",        null: false
    t.string   "sponsor_name"
    t.integer  "collection_id"
    t.boolean  "order_up",                              default: false
    t.integer  "extra_clicks_count"
    t.string   "type",                                  default: "Coupon"
    t.string   "flag"
    t.integer  "merchandise_categories_mask", limit: 8
  end

  create_table "direct_donations", force: :cascade do |t|
    t.string   "email"
    t.string   "card_token"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.string   "donable_type"
    t.integer  "donable_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "extra_clicks", force: :cascade do |t|
    t.string   "url"
    t.boolean  "bonus",          default: false
    t.integer  "browser_id"
    t.integer  "clickable_id"
    t.string   "clickable_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "extra_clicks", ["clickable_type", "clickable_id"], name: "index_extra_clicks_on_clickable_type_and_clickable_id", using: :btree
  add_index "extra_clicks", ["url"], name: "index_extra_clicks_on_url", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

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

  create_table "media_affiliate_campaigns", force: :cascade do |t|
    t.boolean  "use_stripe",            default: false
    t.string   "recipient_name"
    t.integer  "media_affiliate_id"
    t.integer  "community_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "commission_percentage", default: 0
    t.string   "token"
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

  create_table "purchases", force: :cascade do |t|
    t.string   "email"
    t.string   "card_token"
    t.integer  "amount_cents",     default: 0,     null: false
    t.string   "amount_currency",  default: "USD", null: false
    t.string   "purchasable_type"
    t.integer  "purchasable_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip_code"
    t.boolean  "hide_name",        default: false
    t.boolean  "should_charge",    default: true
    t.boolean  "should_notify",    default: true
    t.text     "comment"
  end

  create_table "stripe_accounts", force: :cascade do |t|
    t.string   "uid"
    t.string   "publishable_key"
    t.string   "token"
    t.string   "customer_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "stripe_accounts", ["owner_type", "owner_id"], name: "index_stripe_accounts_on_owner_type_and_owner_id", using: :btree

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

  create_table "transfers", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "balance_transaction_id"
    t.string   "kind"
    t.integer  "amount_cents",           default: 0,     null: false
    t.string   "amount_currency",        default: "USD", null: false
    t.integer  "app_fee_cents",          default: 0,     null: false
    t.string   "app_fee_currency",       default: "USD", null: false
    t.string   "status"
    t.integer  "transferable_id"
    t.string   "transferable_type"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "transfers", ["transferable_type", "transferable_id"], name: "index_transfers_on_transferable_type_and_transferable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "roles_mask"
    t.boolean  "registered",             default: false
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "auth_token"
    t.string   "auth_secret"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "type",                   default: "User", null: false
    t.boolean  "tax_exempt",             default: false
    t.string   "url"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string  "recordable_type"
    t.integer "recordable_id"
    t.string  "url"
    t.string  "provider"
    t.string  "thumbnail"
    t.boolean "auto_show",       default: false
  end

  create_table "vouchers", force: :cascade do |t|
    t.string   "number"
    t.datetime "expires_at"
    t.string   "status",               default: "pending"
    t.integer  "categories_coupon_id"
    t.integer  "purchase_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "vouchers", ["number"], name: "index_vouchers_on_number", unique: true, using: :btree
  add_index "vouchers", ["owner_type", "owner_id"], name: "index_vouchers_on_owner_type_and_owner_id", using: :btree

end
