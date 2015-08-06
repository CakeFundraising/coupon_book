class AddSlugToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :slug, :string
    add_index :coupon_books, :slug, unique: true
  end
end
