class PurchaseDecorator < ApplicationDecorator
  delegate_all
  decorates_association :purchasable

  def amount
    h.humanized_money_with_symbol object.amount
  end

  def email
    h.auto_mail object
  end

  def user
    if object.first_name.present? and object.last_name.present? and !object.hide_name
      "#{object.first_name} #{object.last_name}"
    else
      "Anonymous"      
    end
  end

  def created_at
    h.time_ago_in_words(object.created_at, include_seconds: true)
  end
end