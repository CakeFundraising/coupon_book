class PurchaseDecorator < ApplicationDecorator
  delegate_all
  decorates_association :purchasable

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def amount
    h.humanized_money_with_symbol object.amount
  end

  def form_amount
    amount = object.amount.to_i
    amount = amount.zero? ? '' : amount
    amount
  end

  def email
    h.auto_mail object
  end

  def user
    if object.first_name.present? and object.last_name.present? and !object.hide_name
      full_name
    else
      "Anonymous"
    end
  end

  def created_at
    h.timeago_tag(object.created_at)
  end
end