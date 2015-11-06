module Transferable
  extend ActiveSupport::Concern

  included do
    has_many :transfers, as: :transferable, dependent: :destroy
  end

  def transfer!(amount_cents)
    if stripe_available? and balance_available?(amount_cents)
      stripe_transfer(amount_cents)
      after_transfer(amount_cents)
    else
      SystemMailer.no_funds(amount_cents).deliver_now unless balance_available?(amount_cents) or Rails.env.test?
      #puts 'Stripe is not available' unless stripe_available?
    end
  end

  private

  def balance_available?(amount_cents)
    balance = Stripe::Balance.retrieve
    available_amount = balance.available.first.amount

    available_amount > amount_cents
  end

  def stripe_transfer(amount_cents)
    transfer = Stripe::Transfer.create(
      amount: amount_cents,
      currency: 'usd',
      destination: self.stripe_account.uid,
      description: "EatsForGood.com Campaign #{self.name} Commission",
      statement_descriptor: "EFG Campaign Commission"
    )
    store_transfer(transfer)
  end

  def store_transfer(stripe_transfer)
    bt_id = stripe_transfer.try(:balance_transaction)
    balance_transaction = Stripe::BalanceTransaction.retrieve(bt_id)

    transfer = self.transfers.create(
      stripe_id: stripe_transfer.id,
      balance_transaction_id: bt_id,
      kind: stripe_transfer.object,
      amount_cents: stripe_transfer.amount,
      amount_currency: stripe_transfer.currency.upcase,
      app_fee_cents: balance_transaction.fee + (self.fee_percentage/100)*stripe_transfer.amount,
      status: stripe_transfer.status
    )

    update_commissions(transfer.id)
  end

  def update_commissions(transfer_id)
    self.commissions.pending.update_all(paid: true, transfer_id: transfer_id)
  end
end