class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :position
      t.string :title
      t.datetime :expires_at
      t.text :description
      t.string :promo_code
      t.text :terms_and_conditions
      t.string :url
      t.integer :coupon_categories_mask, limit: 8
      t.integer :coupon_book_id
      t.integer :coupon_category_id
      t.timestamps
    end
  end
end
