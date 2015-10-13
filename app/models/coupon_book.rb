class CouponBook < ActiveRecord::Base
  include Cause
  include Scope
  include Formats
  include Statusable
  include Picturable
  include Screenshotable
  include VisitorActions
  include Templatable
  include Transferable
  include Analytics
  extend FriendlyId

  friendly_id :slug_candidates, use: [:slugged, :history]

  attr_accessor :step

  MIN_PRICE = ENV['MIN_DONATION'].to_i

  COUPON_TEMPLATES = {
    commercial: :grid,
    community: :grid,
    compact: :rectangle,
    original: :rectangle,
    mobile: :square
  }

  COLOR_STATUS = {"incomplete" => "danger", "launched" => "success", "past" => "default"}

  has_statuses :incomplete, :launched, :past
  has_templates :commercial, :community, :compact, :original

  belongs_to :fundraiser

  has_one :video, as: :recordable, dependent: :destroy

  has_one :community, dependent: :destroy
  has_many :affiliate_campaigns, through: :community
  has_many :affiliates, through: :affiliate_campaigns

  has_many :affiliate_purchases, through: :affiliate_campaigns, source: :purchases
  has_many :affiliate_commissions, through: :affiliate_campaigns, source: :commissions
  
  has_many :media_affiliate_campaigns, through: :community
  has_many :media_commissions, through: :media_affiliate_campaigns, source: :commissions
  has_many :media_affiliates, through: :media_affiliate_campaigns
  
  has_many :categories, -> { order("categories.position ASC") }, dependent: :destroy, inverse_of: :coupon_book
  
  has_many :categories_coupons, through: :categories
  has_many :items, through: :categories
  has_many :coupons, through: :categories
  has_many :pr_boxes, through: :categories

  has_many :vouchers, through: :categories_coupons

  has_many :purchases, as: :purchasable
  has_many :commissions, as: :commissionable
  
  has_many :direct_donations, as: :donable

  monetize :goal_cents, numericality: {greater_than: MIN_PRICE}
  monetize :price_cents, numericality: {greater_than_or_equal_to: MIN_PRICE}

  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :video, update_only: true, reject_if: proc {|attrs| attrs[:url].blank? }
  accepts_nested_attributes_for :community, update_only: true, reject_if: :all_blank

  validates :name, :organization_name, :goal, :template, :fundraiser, :avatar, :banner, presence: true
  validates :url, :main_cause, presence: true, if: :persisted?
  validates :bottom_tagline, presence: true, if: ->(book){ book.persisted? and book.commercial_template? }

  validates :categories, length: {maximum: 15}

  #validates :visitor_url, format: {with: DOMAIN_NAME_REGEX, message: I18n.t('errors.url')}, allow_blank: true

  delegate :zip_code, :city, :state_code, :stripe_account, :stripe_account?, to: :fundraiser

  scope :latest, ->{ order('coupon_books.created_at DESC') }
  scope :with_categories, ->{ eager_load(:categories) }

  scope :affiliated, ->{ includes(:community).where.not(communities: {coupon_book_id: nil}) }
  scope :popular, ->{ preloaded.launched.latest }

  scope :preloaded, ->{ eager_load([:direct_donations, :picture, :video]) }

  scope :to_end, ->{ not_past.where("end_date <= ?", Time.zone.now) }
  scope :active, ->{ not_past.where("end_date > ?", Time.zone.now) }

  #Solr
  searchable do
    text :title, boost: 5
    text :headline, :organization_name, boost: 3
    text :story, :mission, :main_cause, :name

    text :fundraiser do
      fundraiser.full_name
    end

    text :zip_code do
      fundraiser.location.zip_code  
    end

    text :city do
      fundraiser.location.city  
    end

    text :state_code do
      fundraiser.location.state_code  
    end

    boolean :tax_exempt do
      fundraiser.tax_exempt
    end

    boolean :active, using: :active?

    string :main_cause
    
    string :zip_code do
      fundraiser.location.zip_code  
    end

    string :status

    integer :coupon_ids, references: Coupon, multiple: true
    integer :pr_box_ids, references: PrBox, multiple: true

    time :created_at

    integer :fundraiser_id
  end

  #Status
  def active?
    end_date >= Date.today and status != 'past'
  end

  #Actions
  def launch!
    #notify_launch if self.launched! and self.update_attribute(:visible, true)
    self.launched!
    self.update_attribute(:visible, true)
  end

  def notify_launch
    sponsors.map(&:users).flatten.each do |user|
      CampaignNotification.campaign_launched(self.id, user.id).deliver if user.sponsor_email_setting.campaign_launch
    end
  end

  def end
    past!
    notify_end
  end

  def notify_end
    CampaignMailer.campaign_ended(self.id).deliver_now
    CampaignMailer.affiliate_invoices(self.id).deliver_now if self.affiliate_campaigns.use_check.any? or self.media_affiliate_campaigns.use_check.any?
  end

  #Analytics
  def no_discount_price
    coupons.sum(:price_cents)/100
  end

  def thermometer
    (current_sales_cents.to_f/goal_cents)*100 unless goal_cents.zero?
  end

  def affiliates_count
    affiliates.count + media_affiliates.count
  end

  #Direct Donations
  def donations_thermometer
    (donations_raised/goal.amount)*100 unless goal.amount == 0.0
  end

  def donations_raised
    direct_donations.map(&:amount).sum.to_f
  end

  def total_donations_and_sales
    donations_raised + current_sales_cents/100.0
  end

  def donation_sales_thermometer
    (total_donations_and_sales/goal.amount)*100 unless goal.amount == 0.0
  end

  #Slugs
  def slug_candidates
    [
      :organization_name,
      [:organization_name, :name]
    ]
  end

  def should_generate_new_friendly_id?
    slug? ? false : slug_changed?
  end

  #Templates
  def coupon_template
    COUPON_TEMPLATES[self.template.to_sym]
  end

  #Fee
  def estimated_fee
    percentage = (self.fee_percentage/100)
    (self.price*percentage)
  end

  def stripe_available?
    stripe_account?
  end

  #Transfers
  def after_transfer(amount_cents)
    CampaignMailer.commissions_transferred(self.id, amount_cents).deliver_now
  end

  #Vouchers
  def process_categories_params(params)
    hash = {categories_attributes: {}}
    params.each_with_index do |category, index|
      category_params = category.last()

      hash[:categories_attributes].merge!({
        "#{index}" => {
          id: category_params['id'], 
          position: index + 1, 
          categories_coupons_attributes: self.process_items(category_params["items"])
        }
      })
    end
    hash
  end

  def process_items(items)
    unless items.nil?
      items.each_with_index do |(pos, item), index|
        item.delete(:title)
        item.delete(:itemType)
        item.delete(:saved)
        item.store(:coupon_id, item.delete(:id))
        item.store(:id, item.delete(:collection_id)) if item.key?(:collection_id)
        item.store(:position, index + 1)
      end
      items
    end
  end

end

