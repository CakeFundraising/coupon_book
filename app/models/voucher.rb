class Voucher < ActiveRecord::Base
  include Statusable

  has_statuses :pending, :redeemed, :expired

  belongs_to :categories_coupon
  belongs_to :purchase

  delegate :coupon, :coupon_book, to: :categories_coupon

  validates :number, :expires_at, :categories_coupon_id, :purchase_id, presence: true
  validates :number, uniqueness: true

  after_initialize :set_number

  private

  def set_number
    self.number = "#{self.coupon_book.id}#{self.purchase_id}#{self.coupon.id}"
  end
end
