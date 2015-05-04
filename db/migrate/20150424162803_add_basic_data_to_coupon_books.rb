class AddBasicDataToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :name, :string
    add_column :coupon_books, :launch_date, :datetime
    add_column :coupon_books, :end_date, :datetime
    add_column :coupon_books, :url, :string
    add_column :coupon_books, :headline, :string
    add_column :coupon_books, :story, :text
    add_column :coupon_books, :status, :string, default: :incomplete
    add_column :coupon_books, :mission, :text
    add_column :coupon_books, :visible, :boolean, default: false
    add_monetize :coupon_books, :goal
    add_monetize :coupon_books, :price
    add_column :coupon_books, :causes_mask, :integer
    add_column :coupon_books, :scopes_mask, :integer
    add_column :coupon_books, :main_cause, :string
  end
end
