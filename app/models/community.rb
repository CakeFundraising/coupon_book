class Community < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: [:slugged, :history]

  COMMISSION = (5..100).step(5).to_a

  belongs_to :coupon_book, inverse_of: :community
  
  has_many :affiliate_campaigns, dependent: :destroy
  has_many :purchases, through: :affiliate_campaigns
  has_many :commissions, through: :purchases

  validates :slug, :commission_percentage, :coupon_book_id, presence: true
  #validates_numericality_of :commission_percentage, greater_than: :commission_percentage

  #Slug
  def should_generate_new_friendly_id?
    slug? ? false : slug_changed?
  end
end
