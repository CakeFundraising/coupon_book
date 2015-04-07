class CouponCategory < ActiveRecord::Base
  belongs_to :coupon_book

  has_many :coupons, -> { order("position ASC") }

  acts_as_list scope: :coupon_book

  validates_associated :coupon_book
end