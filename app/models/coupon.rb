class Coupon < ActiveRecord::Base
  validates :title, :description, :expires_at, presence: true
end