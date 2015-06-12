class Voucher < ActiveRecord::Base
  include Statusable

  has_statuses :pending, :redeemed, :expired

  belongs_to :categories_coupon

  delegate :coupon, :coupon_book, to: :categories_coupon

  validates :number, :owner_email, :expires_at, :categories_coupon_id, presence: true
  validates :number, uniqueness: true
end
