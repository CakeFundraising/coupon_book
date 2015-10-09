class MediaAffiliate < User
  include Stripable
  include Analytics

  has_many :media_affiliate_campaigns, dependent: :destroy
  has_many :coupon_books, through: :media_affiliate_campaigns
  has_many :commissions, through: :media_affiliate_campaigns
  has_many :purchases, through: :commissions

  has_many :subscriptors, as: :object

  alias_method :campaigns, :media_affiliate_campaigns
end