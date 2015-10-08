class TransferDecorator < ApplicationDecorator
  delegate_all

  def amount
    h.humanized_money_with_symbol object.amount
  end

  def transfer_date
    h.time_ago_in_words(object.created_at, include_seconds: true)
  end

  def status
    object.status.titleize
  end

end