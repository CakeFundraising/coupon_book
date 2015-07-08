class SetDefaultStiValueToCoupons < ActiveRecord::Migration
  def change
    change_column :coupons, :type, :string, default: 'Coupon'
  end
end
