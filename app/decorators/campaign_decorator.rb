module CampaignDecorator
  extend ActiveSupport::Concern

  def to_s
    object.name
  end

  def launch_date
    object.launch_date.strftime("%m/%d/%Y") if object.launch_date.present?
  end

  def end_date
    object.end_date.strftime("%m/%d/%Y") if object.end_date.present?
  end

  def price
    h.humanized_money_with_symbol object.price
  end

  def goal
    h.humanized_money_with_symbol object.goal
  end

  def status
    object.status.titleize
  end

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