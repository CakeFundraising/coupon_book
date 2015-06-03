class AddOrderUpAndPrBoxToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :order_up, :boolean, default: false
    add_column :coupons, :pr_box_flag, :boolean, default: false
  end
end
