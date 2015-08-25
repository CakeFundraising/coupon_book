class AddTitleToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :title, :string
    remove_column :coupon_books, :goal_cents, :integer
    add_column :coupon_books, :goal_cents, :bigint, null: false, default: 0
  end
end
