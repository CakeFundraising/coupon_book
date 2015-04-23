class Category < ActiveRecord::Base
  belongs_to :coupon_book

  has_many :categories_coupons
  has_many :coupons, -> { order("position ASC") }, through: :categories_coupons

  acts_as_list scope: :coupon_book

  validates_associated :coupon_book
end