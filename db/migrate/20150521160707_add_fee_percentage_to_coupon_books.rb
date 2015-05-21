class AddFeePercentageToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :fee_percentage, :integer, default: CakeCouponBook::APPLICATION_FEE
  end
end
