module AnalyticsDecorator
  extend ActiveSupport::Concern

  def current_sales
    h.humanized_money_with_symbol (object.current_sales_cents/100.0)
  end

  def total_commission
    h.humanized_money_with_symbol (object.total_commission_cents/100.0)
  end

  def pending_commission
    h.humanized_money_with_symbol (object.pending_commission_cents/100.0)
  end

  def paid_commission
    h.humanized_money_with_symbol (object.paid_commission_cents/100.0)
  end
end