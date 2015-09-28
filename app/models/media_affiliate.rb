class MediaAffiliate < User
  include Stripable

  # has_many :affiliate_campaigns, dependent: :destroy
  # has_many :coupon_books, through: :affiliate_campaigns
  # has_many :commissions, through: :affiliate_campaigns
  has_many :subscriptors, as: :object
end