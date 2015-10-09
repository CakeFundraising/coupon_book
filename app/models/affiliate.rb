class Affiliate < User
  include Analytics
  include Stripable

  has_many :affiliate_campaigns, dependent: :destroy
  has_many :coupon_books, through: :affiliate_campaigns
  has_many :purchases, through: :affiliate_campaigns
  has_many :commissions, through: :affiliate_campaigns

  has_many :subscriptors, as: :object

  alias_method :campaigns, :affiliate_campaigns
end