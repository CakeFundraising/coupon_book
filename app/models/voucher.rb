class Voucher < ActiveRecord::Base
  include Statusable

  has_statuses :pending, :redeemed

  belongs_to :categories_coupon
  belongs_to :purchase
  belongs_to :owner, polymorphic: true

  delegate :purchasable, to: :purchase
  delegate :coupon, :coupon_book, to: :categories_coupon
  delegate :multiple_locations, :custom_terms, to: :coupon

  validates :expires_at, :categories_coupon_id, :purchase_id, presence: true
  validates :number, uniqueness: true, if: :persisted?

  before_save :set_number

  scope :expired, ->{ where("expires_at <= ?", Time.zone.now) }
  scope :not_expired, ->{ where("expires_at > ?", Time.zone.now) }

  def validate_status(sp_id=nil)
    # if self.owner_type != 'Merchant' or self.owner_id != sp_id.to_i
    #   allowed = false
    #   message = 'Sorry, you cannot access this Voucher.'
    if self.redeemed?
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

  def redeem!(sp_id)
    status = validate_status(sp_id)
    
    if status[:allowed]
      self.redeemed!
      {allowed: true, message: "Voucher ##{self.number} redeemed!"}
    else
      status
    end
  end

  def expired?
    self.expires_at <= Time.zone.now
  end

  private

  def set_number
    self.number = "#{self.coupon_book.id}#{self.purchase_id}#{self.coupon.id}" if self.number.blank?
  end
end
