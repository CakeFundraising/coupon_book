class Coupon < ActiveRecord::Base
  include Picturable
  include Statusable
  include MerchandiseCategories

  attr_accessor :collection_id, :terms

  has_statuses :incomplete, :pending, :launched, :past
  
  has_one :location, as: :locatable, dependent: :destroy
  has_many :categories_coupons
  has_many :collections_coupons
  has_many :categories, through: :categories_coupons
  has_many :coupon_books, through: :categories

  delegate :city, :state, :state_code, :country, :address, to: :locations

  validates :phone, :sponsor_url, :multiple_locations, presence: true
  validates :title, :description, :expires_at, :promo_code, :url, presence: true, if: :persisted?
  validates :terms, acceptance: true, if: :new_record?

  accepts_nested_attributes_for :location, update_only: true, reject_if: :all_blank
  validates_associated :location

  monetize :price_cents

  scope :latest, ->{ order('coupons.created_at DESC') }

  after_initialize do
    self.build_location if self.location.nil?
  end
end