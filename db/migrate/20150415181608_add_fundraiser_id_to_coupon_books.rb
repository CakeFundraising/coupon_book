class AddFundraiserIdToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :fundraiser_id, :integer
  end
end
