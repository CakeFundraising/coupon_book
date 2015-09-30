class Commission < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :commissionable, polymorphic: true

  delegate :purchasable, :community, to: :purchase

  monetize :amount_cents

  before_save :set_percentage_and_amount, unless: :coupon_book_commissionable?

  def coupon_book_commissionable?
    commissionable.is_a?(CouponBook)
  end

  protected

  def set_percentage_and_amount
    self.percentage = commissionable.commission_percentage
    self.amount_cents = ((self.percentage*purchase.amount_cents)/100.0).round
  end

end