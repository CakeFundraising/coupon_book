class SystemMailer < ApplicationMailer
  def no_funds(transfer_amount)
    balance = Stripe::Balance.retrieve
    @available_funds = balance.available.first.amount/100.0
    @pending_funds = balance.pending.first.amount/100.0
    @attempted_transfer = transfer_amount/100.0

    #mail(to: 'bismark64@gmail.com', cc: 'joe@eatsforgood.com', subject: "Stripe insufficient funds!")
    mail(to: 'bismark64@gmail.com', subject: "Stripe insufficient funds!")
  end
end