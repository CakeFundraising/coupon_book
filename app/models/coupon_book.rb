class CouponBook < ActiveRecord::Base
  has_many :categories, -> { order("position ASC") }
end