class Purchase < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true, touch: true
  has_one :charge, as: :chargeable, dependent: :destroy

  has_many :commissions, dependent: :destroy
  has_many :vouchers, dependent: :destroy

  attr_accessor :card_number, :exp_month, :exp_year, :cvc, :email_confirmation

  monetize :amount_cents

  accepts_nested_attributes_for :commissions, reject_if: :all_blank

  validates :first_name, :last_name, :zip_code, :purchasable, :card_token, :amount_cents, :email, :token, presence: true

  scope :latest, ->{ order('purchases.created_at DESC') }

  delegate :community, to: :purchasable
  delegate :net_amount, :net_amount_cents, to: :charge

  before_validation :stripe_charge_card

  after_initialize do
    self.token = SecureRandom.uuid if self.token.blank?
  end

  after_create do
    self.create_fr_commission!
    self.update_purchasable_raised!
    Resque.enqueue(ResqueSchedule::AfterPurchase, self.id) if self.should_notify
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

  def create_fr_commission!
    percentage = 100 - commissions.sum(:percentage)
    percentage = 0 if percentage < 0

    amount_cents = ((percentage*self.net_amount_cents)/100.0).floor
    commissionable = self.purchasable.try(:coupon_book) || self.purchasable

    self.commissions.create(commissionable: commissionable, percentage: percentage, amount_cents: amount_cents)
  end

  def update_purchasable_raised!
    previous = self.purchasable.raised_cents
    self.purchasable.update_attribute(:raised_cents, self.amount_cents + previous)
    self.community.touch if self.purchasable.is_a?(AffiliateCampaign) # Clear Community sales cache
  end

  private

  def stripe_charge_card
    unless self.persisted? or !self.should_charge
      begin
        charge = Stripe::Charge.create({
          amount: self.amount_cents,
          currency: self.amount_currency.downcase,
          source: self.card_token,
          description: "Donation from #{self.email} to #{self.purchasable.decorate.fr_name} at EatsForGood.com",
          metadata:{
            email: self.email
          },
          receipt_email: self.email,
          statement_descriptor: "EatsForGood Donation"
        })
        store_transaction(charge)
      rescue Stripe::CardError => e
        self.errors.add(:stripe, e.message)
      rescue Stripe::InvalidRequestError => e
        self.errors.add(:stripe, e.message)
      end
    end
  end

  def stripe_fee_cents(amount_cents)
    (amount_cents*(CakeCouponBook::STRIPE_FEE/100)).round + 30
  end

  def application_fee
    percentage = (self.purchasable.fee_percentage/100)
    (self.amount_cents*percentage).round
  end

  def store_transaction(stripe_transaction)
    if Rails.env.test?
      balance_transaction = OpenStruct.new(fee: stripe_fee_cents(stripe_transaction.amount), fee_details:[{amount: stripe_fee_cents(stripe_transaction.amount), application: application_fee}])
    else
      balance_transaction = Stripe::BalanceTransaction.retrieve(stripe_transaction.balance_transaction)
    end

    self.build_charge(
      stripe_id: stripe_transaction.id,
      balance_transaction_id: stripe_transaction.balance_transaction,
      kind: stripe_transaction.object,
      gross_amount_cents: stripe_transaction.amount,
      net_amount_cents: (stripe_transaction.amount - balance_transaction.fee - application_fee),
      fee_cents: balance_transaction.fee + application_fee,
      paid: stripe_transaction.paid,
      captured: stripe_transaction.captured,
      fee_details: balance_transaction.fee_details.map(&:to_hash)
    ).save
  end
  
end
