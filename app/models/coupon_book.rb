class CouponBook < ActiveRecord::Base
  include Statusable
  include Picturable

  attr_accessor :step

  has_statuses :incomplete, :pending, :launched, :past

  has_many :categories, -> { order("position ASC") }, dependent: :destroy
  has_many :coupons, through: :categories, dependent: :destroy

  monetize :goal_cents, numericality: {greater_than: 0}

  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: :all_blank

  validates :categories, length: {maximum: 5}

  scope :latest, ->{ order('coupon_books.created_at DESC') }

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
end