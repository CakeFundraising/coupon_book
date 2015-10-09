module Analytics
  extend ActiveSupport::Concern

  def current_sales_cents
    purchases.sum(:amount_cents)
  end

  def total_commission_cents
    commissions.sum(:amount_cents)
  end

  def pending_commission_cents
    commissions.pending.sum(:amount_cents)
  end

  def paid_commission_cents
    commissions.paid.sum(:amount_cents)
  end
end