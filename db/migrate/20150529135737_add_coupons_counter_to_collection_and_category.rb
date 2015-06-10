class AddCouponsCounterToCollectionAndCategory < ActiveRecord::Migration
  def change
    add_column :collections, :coupons_count, :integer
    add_column :categories, :coupons_count, :integer
  end
end
