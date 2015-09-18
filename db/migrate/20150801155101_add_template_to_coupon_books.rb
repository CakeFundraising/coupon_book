class AddTemplateToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :template, :string, default: :commercial
  end
end
