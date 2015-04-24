class Category < ActiveRecord::Base
  belongs_to :coupon_book

  has_many :categories_coupons, -> { order("position ASC") }
  has_many :coupons, through: :categories_coupons

  acts_as_list scope: :coupon_book
end