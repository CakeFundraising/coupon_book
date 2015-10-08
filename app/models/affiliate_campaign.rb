class AffiliateCampaign < ActiveRecord::Base
  include Screenshotable
  include Campaign
  extend FriendlyId

  friendly_id :slug_candidates, use: [:slugged, :history]

  belongs_to :affiliate
  belongs_to :community

  has_one :coupon_book, through: :community
  has_one :fundraiser, through: :coupon_book

  has_one :avatar_picture, as: :avatarable, dependent: :destroy
  has_one :location, as: :locatable, dependent: :destroy

  has_many :purchases, as: :purchasable
  has_many :commissions, as: :commissionable

  validates :community, presence: true
  validates :first_name, :last_name, :phone, :email, presence: true, if: ->(c){ c.persisted? and c.coupon_book.commercial_template? }
  validates :organization_name, :url, :story, presence: true, if: ->(c){ c.persisted? and c.coupon_book.community_template? }

  validates_associated :avatar_picture, if: ->(c){ c.persisted? and c.coupon_book.community_template? }
  validates_associated :location, if: ->(c){ c.persisted? and !c.use_stripe }

  accepts_nested_attributes_for :location, update_only: true, reject_if: ->(attrs){ attrs[:address].blank? }
  accepts_nested_attributes_for :avatar_picture, update_only: true, reject_if: :all_blank

  scope :latest, ->{ order('affiliate_campaigns.created_at DESC') }

  delegate :name, :launch_date, :end_date, :status, :price, :goal, :fee_percentage, :fundraiser, :categories_coupons, to: :coupon_book
  delegate :affiliate_commission_percentage, to: :community
  delegate :stripe_account, :stripe_account?, to: :affiliate

  scope :preloaded, ->{ eager_load([:coupon_book]) }

  before_save do
    self.commission_percentage = community.affiliate_commission_percentage if self.commission_percentage.zero?
  end

  #Slugs
  def slug_candidates
    [
      :organization_name,
      [:organization_name, :id]
    ]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def should_generate_new_friendly_id?
    organization_name.present? ? organization_name_changed? : false
  end

  #Transfers
  def after_transfer(amount_cents)
    AffiliateCampaignMailer.commissions_transferred(self.id, amount_cents).deliver_now
  end

  def stripe_available?
    use_stripe and stripe_account?
  end
end
