class DirectDonation < ActiveRecord::Base
  belongs_to :donable, polymorphic: true, touch: true
  has_one :charge, as: :chargeable

  monetize :amount_cents

  validates :donable, :card_token, :amount, :email, presence: true

  before_create :stripe_charge_card

  private

  def stripe_charge_card
    begin
      charge = Stripe::Charge.create({
        amount: self.amount_cents,
        currency: self.amount_currency.downcase,
        source: self.card_token,
        description: "Direct Donation from #{self.email}",
        metadata:{
          email: self.email
        },
        receipt_email: self.email,
        statement_descriptor: "#{self.donable.decorate.fr_name} Donation",
        application_fee: application_fee
      },
        stripe_account: self.donable.fundraiser.stripe_account_id
      )
      store_transaction(charge)
    rescue Stripe::CardError => e
      # The card has been declined
      self.card_token = nil # Force validation to fail
    end
  end

  def application_fee
    percentage = (self.donable.fee_percentage/100.0)
    (self.amount_cents*percentage).round
  end

  def store_transaction(stripe_transaction) 
    balance_transaction = Stripe::BalanceTransaction.retrieve(stripe_transaction.balance_transaction, self.donable.fundraiser.stripe_account_token)

    self.build_charge(
      stripe_id: stripe_transaction.id,
      balance_transaction_id: stripe_transaction.balance_transaction,
      kind: stripe_transaction.object,
      amount_cents: stripe_transaction.amount,
      amount_currency: stripe_transaction.currency.upcase,
      total_fee_cents: balance_transaction.fee,
      paid: stripe_transaction.paid,
      captured: stripe_transaction.captured,
      fee_details: balance_transaction.fee_details.map(&:to_hash)
    ).save
  end
end
