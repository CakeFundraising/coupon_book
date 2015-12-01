class CommissionDecorator < ApplicationDecorator
  delegate_all
  decorates_association :purchase

  delegate :full_name, :email, :plain_email, to: :purchase

  def amount
    h.humanized_money_with_symbol object.amount
  end

  def gross_amount
    purchase.object.amount
  end

end