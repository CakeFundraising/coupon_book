class CreateCouponBook < ActiveRecord::Migration
  def change
    create_table :coupon_books do |t|
      t.integer :coupon_book_campaign_id
      t.timestamps
    end
  end
end
