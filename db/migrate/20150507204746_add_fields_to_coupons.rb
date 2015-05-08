class AddFieldsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :phone, :string
    add_column :coupons, :sponsor_url, :string
    add_column :coupons, :multiple_locations, :string
    add_column :coupons, :retail_value, :money
    add_column :coupons, :universal, :boolean, default: false
    add_column :coupons, :status, :string, default: :incomplete
  end
end
