class AddFieldsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :phone, :string
    add_column :coupons, :sponsor_url, :string
    add_column :coupons, :multiple_locations, :string
    add_column :coupons, :universal, :boolean, default: false
    add_column :coupons, :status, :string, default: :incomplete
    add_column :coupons, :custom_terms, :text
    add_column :coupons, :merchandise_categories_mask, :integer
    add_monetize :coupons, :price
  end
end
