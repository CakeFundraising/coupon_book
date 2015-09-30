class Community < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: [:slugged, :history]
  
  include Screenshotable

  COMMISSION = (0..100).step(5).to_a

  belongs_to :coupon_book, inverse_of: :community
  
  has_many :affiliate_campaigns, dependent: :destroy
  has_many :affiliate_purchases, through: :affiliate_campaigns, source: :purchases
  has_many :commissions, through: :affiliate_purchases

  has_many :media_affiliate_campaigns, dependent: :destroy

  validates :slug, :affiliate_commission_percentage, :fr_commission_percentage, :media_commission_percentage, :coupon_book_id, presence: true
  validate :commissions_sum

  delegate :title, :headline, :organization_name, :story, :mission, :fundraiser, :zip_code, :city, :state_code, :status, :main_cause, :active?, to: :coupon_book

  scope :latest, ->{ order('communities.created_at DESC') }
  scope :preloaded, ->{ eager_load(:coupon_book) }
  scope :launched, ->{ preloaded.where(coupon_books: {status: :launched}) }

  scope :popular, ->{ launched.latest }

  before_save :update_fr_commission

  #Solr
  searchable do
    text :title, boost: 5
    text :headline, :organization_name, boost: 3
    text :story, :mission, :main_cause, :zip_code, :fundraiser, :city, :state_code

    boolean :active, using: :active?

    string :main_cause
    
    string :zip_code do
      fundraiser.location.zip_code  
    end

    string :status

    time :created_at
  end

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

  protected

  def commissions_sum
    sum = self.affiliate_commission_percentage + self.media_commission_percentage
    errors.add(:media_commission_percentage, "The sum of Affiliate and Media commissions can't be more than 100%") if sum > 100
  end

  def update_fr_commission
    self.fr_commission_percentage = (100 - self.affiliate_commission_percentage - self.media_commission_percentage)
  end
end
