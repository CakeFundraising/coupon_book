class Purchase < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true
  has_one :charge, as: :chargeable

  monetize :amount_cents

  validates :purchasable, :card_token, :amount, :email, presence: true

  before_create :stripe_charge_card
  after_create :create_and_send_vouchers

  private

  def stripe_charge_card
    begin
      charge = Stripe::Charge.create({
        amount: self.amount_cents,
        currency: self.amount_currency.downcase,
        source: self.card_token,
        description: "Purchase from #{self.email} to #{self.purchasable.class} ##{self.purchasable.id}",
        metadata:{
          email: self.email
        },
        receipt_email: self.email,
        statement_descriptor: "Cake #{self.purchasable.class} ##{self.purchasable.id}",
        application_fee: application_fee
      },
        stripe_account: self.purchasable.fundraiser.stripe_account_id
      )
      store_transaction(charge)
    rescue Stripe::CardError => e
      # The card has been declined
      self.card_token = nil # Force validation to fail
    end
  end

  def application_fee
    percentage = (self.purchasable.fee_percentage/100.0)
    (self.amount_cents*percentage).round
  end

  def store_transaction(stripe_transaction) 
    balance_transaction = Stripe::BalanceTransaction.retrieve(stripe_transaction.balance_transaction, self.purchasable.fundraiser.stripe_account_token)

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

  def create_and_send_vouchers
    vouchers_ids = self.purchasable.create_vouchers(self.id)
    VoucherMailer.coupon_book(self.purchasable.id, self.email, vouchers_ids).deliver_now
  end

end
