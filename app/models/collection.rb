class Collection < ActiveRecord::Base

  has_many :collections_coupons, -> { order("position ASC") }
  has_many :coupons, through: :collections_coupons

end