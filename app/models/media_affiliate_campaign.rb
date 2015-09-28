class MediaAffiliateCampaign < ActiveRecord::Base
  belongs_to :media_affiliate
  belongs_to :community

  has_one :coupon_book, through: :community
  has_one :location, as: :locatable, dependent: :destroy

  validates :community, presence: true

  validates_associated :location, if: ->(c){ c.persisted? and !c.use_stripe }

  accepts_nested_attributes_for :location, update_only: true, reject_if: ->(attrs){ attrs[:address].blank? }

  scope :latest, ->{ order('media_affiliate_campaigns.created_at DESC') }

  scope :preloaded, ->{ eager_load([:coupon_book]) }

  delegate :name, :end_date, :status, :fee_percentage, :fundraiser, to: :coupon_book
  #delegate :commission_percentage, to: :community

  def current_sales_cents
    #purchases.sum(:amount_cents)
    0
  end

  def current_commission_cents
    #commissions.sum(:amount_cents)
    0
  end
end
