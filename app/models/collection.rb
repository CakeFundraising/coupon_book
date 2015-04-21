class Collection < ActiveRecord::Base

  has_many :collections_coupons
  has_many :coupons, -> { order("position ASC") }, through: :collections_coupons

  # belongs_to :fundraiser

end