class AffiliateCampaign < ActiveRecord::Base
  include Screenshotable
  extend FriendlyId

  friendly_id :slug_candidates, use: [:slugged, :history]

  belongs_to :affiliate
  belongs_to :coupon_book

  has_one :avatar_picture, as: :avatarable, dependent: :destroy
  has_one :location, as: :locatable, dependent: :destroy

  validates :coupon_book, presence: true
  validates :first_name, :last_name, :phone, :email, presence: true, if: ->(c){ c.persisted? and c.coupon_book.commercial_template? }
  validates :organization_name, :url, :story, presence: true, if: ->(c){ c.persisted? and c.coupon_book.community_template? }

  validates_associated :avatar_picture, if: ->(c){ c.persisted? and c.coupon_book.community_template? }
  validates_associated :location, if: ->(c){ c.persisted? and !c.use_stripe }

  accepts_nested_attributes_for :location, update_only: true, reject_if: ->(attrs){ attrs[:address].blank? }
  accepts_nested_attributes_for :avatar_picture, update_only: true, reject_if: :all_blank

  scope :latest, ->{ order('affiliate_campaigns.created_at DESC') }

  delegate :name, :end_date, :current_sales_cents, :status, to: :coupon_book

  scope :preloaded, ->{ eager_load([:coupon_book]) }

  #Slugs
  def slug_candidates
    [
      :organization_name,
      [:organization_name, :id]
    ]
  end

  def should_generate_new_friendly_id?
    organization_name.present? ? organization_name_changed? : false
  end
end
