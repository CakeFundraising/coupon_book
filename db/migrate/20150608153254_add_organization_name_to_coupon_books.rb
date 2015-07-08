class AddOrganizationNameToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :organization_name, :string
  end
end
