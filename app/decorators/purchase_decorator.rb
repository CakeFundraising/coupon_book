class PurchaseDecorator < ApplicationDecorator
  delegate_all

  def amount
    h.humanized_money_with_symbol object.amount
  end

  def email
    h.auto_mail object
  end
end