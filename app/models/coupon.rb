class Coupon < ActiveRecord::Base
  include Picturable
  attr_accessor :collection_id

  has_many :categories_coupons
  has_many :collections_coupons
  has_many :categories, through: :categories_coupons
  has_many :coupon_books, through: :categories

  validates :title, :description, :expires_at, presence: true

  scope :latest, ->{ order('coupons.created_at DESC') }

  searchable do
    text :title, boost: 2
    text :promo_code, :description

    time :created_at
  end
end