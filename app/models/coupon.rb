class Coupon < ActiveRecord::Base
  has_many :categories_coupons
  has_many :collections_coupons

  include Picturable

  validates :title, :description, :expires_at, presence: true

  attr_accessor :collection_id
end