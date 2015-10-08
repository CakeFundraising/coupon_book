class Commission < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :transfer
  belongs_to :commissionable, polymorphic: true

  delegate :purchasable, :community, to: :purchase

  monetize :amount_cents

  scope :paid, -> { where(paid: true) }
  scope :pending, -> { where(paid: false) }

  scope :group_by_commissionable, -> { select('commissions.commissionable_type, commissions.commissionable_id, SUM(commissions.amount_cents) AS total_cents').group(:commissionable_type, :commissionable_id).having('SUM(commissions.amount_cents) > ?', 1000) }

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