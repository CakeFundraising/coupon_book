class CouponBook < ActiveRecord::Base
  include Statusable
  include Picturable

  attr_accessor :step

  has_statuses :incomplete, :pending, :launched, :past

  has_many :categories, -> { order("categories.position ASC") }, dependent: :destroy
  has_many :coupons, through: :categories, dependent: :destroy

  monetize :goal_cents, numericality: {greater_than: 0}

  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: :all_blank

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

  # #Sorting
  # def update_categories!(tree)
  #   tree.each_with_index do |(category, coupons), index|
  #     category_id = category.gsub('cat_', '').to_i
  #     category_position = index + 1
  #     category = Category.find(category_id)

  #     category.set_list_position(category_position)

  #     category.update_coupons!(coupons) unless coupons.nil?
  #   end
  # end
end