class CouponCollection < ActiveRecord::Base

  has_many :coupons

  # belongs_to :fundraiser

end