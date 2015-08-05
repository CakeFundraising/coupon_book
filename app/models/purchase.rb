class Purchase < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true
  has_one :charge, as: :chargeable
  has_many :vouchers, dependent: :destroy

  attr_accessor :card_number, :exp_month, :exp_year, :cvc, :email_confirmation

  monetize :amount_cents

  validates :first_name, :last_name, :zip_code, :purchasable, :card_token, :amount, :email, :token, presence: true

  before_validation :stripe_charge_card

  scope :latest, ->{ order('purchases.created_at DESC') }

  after_initialize do
    self.token = SecureRandom.uuid if self.token.blank?
  end

  after_create do
    Resque.enqueue(ResqueSchedule::AfterPurchase, self.id)
  end

  def create_vouchers!
    unless self.vouchers.any?
      purchasable.categories_coupons.each do |cc|
        cc.create_voucher(self.id)
      end
    end
  end

  def vouchers_count
    vouchers.count
  end

  def resend_emails
    Resque.enqueue(ResqueSchedule::ResendEmails, self.id)
  end

  private

  def stripe_charge_card
    unless self.persisted?
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
          statement_descriptor: "EFG.org #{self.purchasable.class} ##{self.purchasable.id}",
          application_fee: application_fee
        },
          stripe_account: self.purchasable.fundraiser.stripe_account_id
        )
        store_transaction(charge)
      rescue Stripe::CardError => e
        self.errors.add(:stripe, e.message)
      rescue Stripe::InvalidRequestError => e
        self.errors.add(:stripe, e.message)
      end
    end
  end

  def application_fee
    percentage = (self.purchasable.fee_percentage/100)
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

end
