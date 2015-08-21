class AddBottomTaglineToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :bottom_tagline, :string
  end
end
