class Coupon < ActiveRecord::Base
  include Picturable
  include Statusable
  include MerchandiseCategories

  attr_accessor :fr_collection_id, :terms

  has_statuses :incomplete, :launched, :past
  
  has_one :location, as: :locatable, dependent: :destroy
  has_one :avatar_picture, as: :avatarable, dependent: :destroy #Sponsor Picture
  
  belongs_to :origin_collection, class_name: 'Collection', foreign_key: :collection_id

  has_many :categories_coupons, dependent: :destroy
  has_many :collections_coupons, dependent: :destroy
  has_many :categories, through: :categories_coupons
  has_many :coupon_books, through: :categories

  has_many :vouchers, through: :categories_coupons

  delegate :city, :state, :state_code, :zip_code, :country, :address, to: :location

  validates :phone, :sponsor_name, :sponsor_url, :collection_id, presence: true
  validates :title, :description, :expires_at, :promo_code, :url, presence: true, if: :persisted?
  validates :terms, acceptance: true, if: :new_record?

  accepts_nested_attributes_for :location, update_only: true, reject_if: :all_blank
  accepts_nested_attributes_for :avatar_picture, update_only: true, reject_if: :all_blank
  
  validates_associated :location
  validates_associated :avatar_picture

  monetize :price_cents

  scope :latest, ->{ order('coupons.created_at DESC') }

  scope :to_end, ->{ not_past.where("expires_at <= ?", Time.zone.now) }
  scope :active, ->{ not_past.where("expires_at > ?", Time.zone.now) }

  alias_method :sp_picture, :avatar_picture

  delegate :owner, :owner_type, :owner_id, to: :origin_collection

  searchable do
    text :title, boost: 2
    text :promo_code, :description, :sponsor_url, :multiple_locations, :sponsor_name, :city, :state_code, :state, :zip_code
    string :status
    string :merchandise_categories, multiple: true
    boolean :universal
    time :created_at
  end

  after_initialize do
    self.build_location if self.location.nil?
  end

  after_create :add_to_collection

  def self.build_sp_coupon(sponsor)
    collection_id = sponsor.collection.id
    coupon = Coupon.new(
      sponsor_name: sponsor.name,
      phone: sponsor.phone,
      sponsor_url: sponsor.website,
      collection_id: collection_id
    )
    coupon.build_location(
      address: sponsor.location_address,
      city: sponsor.location_city,
      zip_code: sponsor.location_zip_code,
      state_code: sponsor.location_state_code,
      country_code: sponsor.location_country_code
    )
    coupon.build_avatar_picture(
      uri: sponsor.avatar,
      caption: sponsor.avatar_caption,
      avatar_crop_x: sponsor.avatar_crop_x,
      avatar_crop_y: sponsor.avatar_crop_y,
      avatar_crop_w: sponsor.avatar_crop_w,
      avatar_crop_h: sponsor.avatar_crop_h,
      bypass_cloudinary_validation: true
    )
    coupon
  end

  def self.build_fr_coupon(fundraiser)
    collection_id = fundraiser.collection.id
    Coupon.new(collection_id: collection_id)
  end

  private

  def add_to_collection
    self.collections_coupons.create(collection_id: self.collection_id) #Add coupon to owner's collection
  end
end