class MigrateMasksToBigint < ActiveRecord::Migration
  def change
    remove_column :coupon_books, :causes_mask, :integer
    remove_column :coupon_books, :scopes_mask, :integer
    remove_column :coupons, :merchandise_categories_mask, :integer

    add_column :coupon_books, :causes_mask, :bigint
    add_column :coupon_books, :scopes_mask, :bigint
    add_column :coupons, :merchandise_categories_mask, :bigint
  end
end
