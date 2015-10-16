class MediaAffiliateCampaign < ActiveRecord::Base
  include Transferable
  include Analytics

  belongs_to :media_affiliate
  belongs_to :community

  has_one :coupon_book, through: :community
  has_one :fundraiser, through: :coupon_book

  has_one :location, as: :locatable, dependent: :destroy

  has_many :commissions, as: :commissionable
  has_many :purchases, through: :commissions

  validates :community, :media_affiliate, presence: true

  validates_associated :location, if: ->(c){ c.persisted? and !c.use_stripe }

  accepts_nested_attributes_for :location, update_only: true, reject_if: ->(attrs){ attrs[:address].blank? }

  scope :latest, ->{ order('media_affiliate_campaigns.created_at DESC') }
  scope :preloaded, ->{ eager_load([:coupon_book]) }
  
  scope :use_stripe, -> { where(use_stripe: true) }
  scope :use_check, -> { where(use_stripe: false) }

  scope :launched, -> { preloaded.where(coupon_books: {status: :launched}) }
  scope :incomplete, -> { preloaded.where(coupon_books: {status: :incomplete}) }
  scope :past, -> { preloaded.where(coupon_books: {status: :past}) }
  scope :not_past, -> { preloaded.where.not(coupon_books: {status: :past}) }

  scope :rate_bigger_than, ->(rate){ where('media_affiliate_campaigns.commission_percentage > ?', rate) }

  delegate :name, :launch_date, :end_date, :status, :fee_percentage, :fundraiser, :price, :goal, to: :coupon_book
  delegate :stripe_account, :stripe_account?, to: :media_affiliate

  before_save do
    self.token = SecureRandom.uuid if self.token.blank?
    self.commission_percentage = community.media_commission_percentage if self.commission_percentage.zero?
  end

  #Transfers
  def after_transfer(amount_cents)
    MediaAffiliateCampaignMailer.commissions_transferred(self.id, amount_cents).deliver_now
  end

  def stripe_available?
    use_stripe and stripe_account?
  end
end
