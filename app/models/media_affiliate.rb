class MediaAffiliate < User
  include Stripable

  has_many :media_affiliate_campaigns, dependent: :destroy
  has_many :coupon_books, through: :media_affiliate_campaigns
  has_many :commissions, through: :media_affiliate_campaigns
  has_many :subscriptors, as: :object
end