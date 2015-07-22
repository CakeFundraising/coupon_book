class UpdateFeePercentageInCouponBooks < ActiveRecord::Migration
  def self.up
    change_column :coupon_books, :fee_percentage, :float, default: CakeCouponBook::APPLICATION_FEE
  end

  def self.down
    change_column :coupon_books, :fee_percentage, :integer, default: CakeCouponBook::APPLICATION_FEE
  end
end
