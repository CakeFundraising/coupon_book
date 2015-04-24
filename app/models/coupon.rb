class Coupon < ActiveRecord::Base
  include Picturable
  attr_accessor :collection_id
  
  has_many :categories_coupons
  has_many :collections_coupons

  validates :title, :description, :expires_at, presence: true
end