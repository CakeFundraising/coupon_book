class Community < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: [:slugged, :history]

  COMMISSION = (5..100).step(5).to_a

  belongs_to :coupon_book, inverse_of: :community
  
  has_many :affiliate_campaigns, dependent: :destroy
  has_many :affiliate_purchases, through: :affiliate_campaigns, source: :purchases
  has_many :commissions, through: :affiliate_purchases

  validates :slug, :commission_percentage, :coupon_book_id, presence: true
  #validates_numericality_of :commission_percentage, greater_than: :commission_percentage

  #Slug
  def should_generate_new_friendly_id?
    slug? ? false : slug_changed?
  end

  def total_sales_cents
    affiliate_purchases.sum(:amount_cents) + coupon_book.current_sales_cents
  end

  def sales_thermometer
    (total_sales_cents.to_f/coupon_book.goal_cents)*100 unless coupon_book.goal_cents.zero?
  end

  def purchases
    (affiliate_purchases + coupon_book.purchases).sort_by(&:created_at).reverse!
  end
end
