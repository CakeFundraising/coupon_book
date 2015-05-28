class ChangeMultipleLocationsTypeInCoupons < ActiveRecord::Migration
  def change
    change_column :coupons, :multiple_locations, :text
  end
end
