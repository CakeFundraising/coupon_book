module Transferable
  extend ActiveSupport::Concern

  def transfer!(amount_cents)
    if stripe_available? and balance_available?(amount_cents)
      stripe_transfer(amount_cents)
      after_transfer
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
      currency: 'US',
      destination: self.stripe_account.uid,
      description: "EatsForGood.com Campaign #{self.name} Commission",
      statement_descriptor: "EFG Campaign Commission"
    )
    store_transfer(transfer)
  end

  def store_transfer(stripe_transfer)
    balance_transaction = Stripe::BalanceTransaction.retrieve(stripe_transfer.balance_transaction)

    self.transfers.build(
      stripe_id: stripe_transfer.id,
      balance_transaction_id: stripe_transfer.balance_transaction,
      kind: stripe_transfer.object,
      amount_cents: stripe_transfer.amount,
      amount_currency: stripe_transfer.currency.upcase,
      total_fee_cents: balance_transaction.fee,
      status: stripe_transfer.status
    ).save
  end
end