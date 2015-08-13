class CouponBook < ActiveRecord::Base
  include Cause
  include Scope
  include Formats
  include Statusable
  include Picturable
  include Screenshotable
  include VisitorActions
  include Templatable
  extend FriendlyId

  friendly_id :slug_candidates, use: [:slugged, :history]

  attr_accessor :step

  MIN_PRICE = ENV['MIN_DONATION'].to_i

  has_statuses :incomplete, :launched, :past
  has_templates :compact, :commercial, :original

  has_one :video, as: :recordable, dependent: :destroy
  has_many :categories, -> { order("categories.position ASC") }, dependent: :destroy, inverse_of: :coupon_book
  
  has_many :categories_coupons, through: :categories
  has_many :items, through: :categories
  has_many :coupons, through: :categories
  has_many :pr_boxes, through: :categories

  has_many :vouchers, through: :categories_coupons

  has_many :purchases, as: :purchasable
  has_many :direct_donations, as: :donable

  monetize :goal_cents, numericality: {greater_than: MIN_PRICE}
  monetize :price_cents, numericality: {greater_than_or_equal_to: MIN_PRICE}

  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :video, update_only: true, reject_if: proc {|attrs| attrs[:url].blank? }

  validates :name, :organization_name, :goal, :template, :fundraiser, :avatar, :banner, presence: true
  validates :headline, :story, :url, :main_cause, presence: true, if: :persisted?
  validates :categories, length: {maximum: 15}

  #validates :visitor_url, format: {with: DOMAIN_NAME_REGEX, message: I18n.t('errors.url')}, allow_blank: true

  scope :latest, ->{ order('coupon_books.created_at DESC') }
  scope :with_categories, ->{ eager_load(:categories) }

  scope :preloaded, ->{ eager_load([:direct_donations, :picture, :video]) }

  scope :to_end, ->{ not_past.where("end_date <= ?", Time.zone.now) }
  scope :active, ->{ not_past.where("end_date > ?", Time.zone.now) }

  def fundraiser
    Fundraiser.fetch(self.fundraiser_id)
  end

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

  def no_discount_price
    coupons.sum(:price_cents)/100
  end

  def current_sales_cents
    #purchases.count*self.price_cents
    purchases.sum(:amount_cents)
  end

  def thermometer
    (current_sales_cents.to_f/goal_cents)*100 unless goal_cents.zero?
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
    organization_name_changed?
  end

  #Fee
  def estimated_fee
    percentage = (self.fee_percentage/100)
    (self.price*percentage)
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

