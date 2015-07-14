class PurchaseDecorator < ApplicationDecorator
  delegate_all
  decorates_association :purchasable

  def amount
    h.humanized_money_with_symbol object.amount
  end

  def email
    h.auto_mail object
  end
end