class AddScreenshotToCouponBooks < ActiveRecord::Migration
  def change
    remove_column :coupon_books, :coupon_book_campaign_id, :integer
    add_column :coupon_books, :screenshot_url, :string
    add_column :coupon_books, :screenshot_version, :string
  end
end
