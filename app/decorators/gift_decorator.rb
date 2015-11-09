class GiftDecorator < ApplicationDecorator
  delegate_all

  def email
    h.auto_mail object
  end
end