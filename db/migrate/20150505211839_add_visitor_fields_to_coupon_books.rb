class AddVisitorFieldsToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :visitor_url, :string
    add_column :coupon_books, :visitor_action, :string
  end
end
