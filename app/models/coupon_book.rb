class CouponBook < ActiveRecord::Base
  include Cause
  include Scope
  include Formats
  include Statusable
  include Picturable
  include Screenshotable
  include VisitorActions

  attr_accessor :step

  has_statuses :incomplete, :pending, :launched, :past

  has_one :video, as: :recordable, dependent: :destroy
  has_many :categories, -> { order("categories.position ASC") }, dependent: :destroy
  has_many :coupons, through: :categories, dependent: :destroy

  has_many :purchases, as: :purchasable

  monetize :goal_cents, numericality: {greater_than: 0}
  monetize :price_cents, numericality: {greater_than: 0}

  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :video, update_only: true, reject_if: proc {|attrs| attrs[:url].blank? }

  validates :name, :launch_date, :end_date, :main_cause, :scopes, :fundraiser, :goal, presence: true
  validates :visitor_url, format: {with: DOMAIN_NAME_REGEX, message: I18n.t('errors.url')}, allow_blank: true
  validates :mission, :headline, :story, presence: true, if: :persisted?
  validates :categories, length: {maximum: 5}

  scope :latest, ->{ order('coupon_books.created_at DESC') }
  scope :with_categories, ->{ eager_load(:categories) }

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
    purchases.count*self.price_cents
  end

  def thermometer
    (current_sales_cents.to_f/goal_cents)*100 unless goal_cents.zero?
  end
end