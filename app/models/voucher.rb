class Voucher < ActiveRecord::Base
  include Statusable

  has_statuses :pending, :redeemed, :expired

  belongs_to :categories_coupon
  belongs_to :purchase

  delegate :coupon, :coupon_book, to: :categories_coupon

  validates :number, :expires_at, :categories_coupon_id, :purchase_id, presence: true
  validates :number, uniqueness: true

  after_initialize :set_number

  def validate_status(sp_id)
    if self.coupon.owner_type != 'Sponsor' or self.coupon.owner_id != sp_id.to_i
      allowed = false
      message = 'Sorry, you cannot access this Voucher.'
    elsif self.redeemed?
      allowed = false
      message = 'Sorry, this Voucher has been redeemed already.'
    elsif self.expired?
      allowed = false
      message = 'Sorry, this Voucher has expired.'
    else
      allowed = true
      message = 'Valid Voucher.'
    end

    {
      allowed: allowed,
      message: message
    }
  end

  private

  def set_number
    self.number = "#{self.coupon_book.id}#{self.purchase_id}#{self.coupon.id}"
  end
end
