class Coupon < ActiveRecord::Base
  include Picturable
  attr_accessor :collection_id
  
  has_many :categories_coupons
  has_many :collections_coupons
  has_many :categories, through: :categories_coupons
  has_many :coupon_books, through: :categories

  validates :title, :description, :expires_at, presence: true
end