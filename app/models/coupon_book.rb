class CouponBook < ActiveRecord::Base
  has_many :coupon_categories, -> { order("position ASC") }, validate: false, dependent: :destroy
  has_many :coupons, dependent: :destroy

  validate :categories_count_within_bounds, on: :create

  private

  def categories_count_within_bounds
    return if coupon_categories.blank?
    errors.add("Too many coupon categories") if coupon_categories.size > 5
  end
end