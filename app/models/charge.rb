class Charge < ActiveRecord::Base
  belongs_to :chargeable, polymorphic: true

  monetize :gross_amount_cents
  monetize :net_amount_cents
  monetize :fee_cents

  def resource
    Stripe::Charge.retrieve(self.stripe_id, token)
  end

  def balance_transaction
    Stripe::BalanceTransaction.retrieve(self.balance_transaction_id, token)
  end

  private
  
  def token
    if chargeable_type == 'Purchase'
      chargeable.purchasable.fundraiser.stripe_account.token
    end
  end
end
