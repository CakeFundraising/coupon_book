class AffiliateCampaign < ActiveRecord::Base
  belongs_to :affiliate
  belongs_to :coupon_book

  has_one :avatar_picture, as: :avatarable, dependent: :destroy
  has_one :location, as: :locatable, dependent: :destroy

  validates :first_name, :last_name, :phone, :email, presence: true, if: ->(c){ c.persisted? and c.coupon_book.commercial_template? }
  validates :organization_name, :url, :story, presence: true, if: ->(c){ c.persisted? and c.coupon_book.community_template? }

  validates_associated :avatar_picture, if: ->(c){ c.persisted? and c.coupon_book.community_template? }
  #validates_associated :location, if: :coupon?

  scope :latest, ->{ order('affiliate_campaigns.created_at DESC') }
end
