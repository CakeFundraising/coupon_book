class Coupon < ActiveRecord::Base
  include Picturable
  include Statusable
  include MerchandiseCategories
  include ExtraClickable

  attr_accessor :fr_collection_id, :terms, :disabled

  has_statuses :incomplete, :launched, :past
  
  has_one :location, as: :locatable, dependent: :destroy
  has_one :avatar_picture, as: :avatarable, dependent: :destroy #Merchant Picture
  
  belongs_to :origin_collection, class_name: 'Collection', foreign_key: :collection_id
  has_one :owner, through: :origin_collection, source_type:'User'

  has_many :categories_coupons, dependent: :destroy
  has_many :collections_coupons, dependent: :destroy
  has_many :categories, through: :categories_coupons
  has_many :coupon_books, through: :categories

  has_many :vouchers, through: :categories_coupons
  has_many :collections, through: :collections_coupons

  validates :collection_id, :sponsor_name, presence: true
  validates :phone, presence: true, if: :coupon?
  validates :title, :description, :expires_at, :url, presence: true, if: -> (coupon){ coupon.coupon? and coupon.persisted? }
  validates :terms, acceptance: true, if: -> (coupon){ coupon.coupon? and coupon.new_record? }

  accepts_nested_attributes_for :location, update_only: true, reject_if: :all_blank
  accepts_nested_attributes_for :avatar_picture, update_only: true, reject_if: :all_blank
  
  validates_associated :location, if: :coupon?
  validates_associated :avatar_picture, if: :coupon?

  monetize :price_cents

  scope :latest, ->{ order('coupons.created_at DESC') }

  scope :to_end, ->{ not_past.where("expires_at <= ?", Time.zone.now) }
  scope :active, ->{ not_past.where("expires_at > ?", Time.zone.now) }

  scope :universal, ->{ where(universal: true) }

  scope :preloaded, ->{ eager_load([:location, :picture, :avatar_picture]) }

  scope :coupon, -> {where(type: 'Coupon')}
  scope :pr_box, -> {where(type: 'PrBox')}

  scope :popular, -> { preloaded.coupon.launched.latest }

  alias_method :sp_picture, :avatar_picture
  alias_method :active?, :launched?

  delegate :city, :state, :state_code, :zip_code, :country, :address, to: :location, allow_nil: true

  searchable do
    text :title, boost: 2
    text :promo_code, :description, :multiple_locations, :sponsor_name, :city, :state_code, :state, :zip_code
    string :status
    string :type
    string :merchandise_categories, multiple: true
    boolean :universal
    time :created_at
    integer :collection_id
  end

  after_create :add_to_collection

  def self.build_merchant_coupon(merchant)
    collection_id = merchant.collection.id
    coupon = Coupon.new(
      sponsor_name: merchant.organization_name || merchant.full_name,
      phone: merchant.phone,
      collection_id: collection_id
    )
    coupon.build_location(
      address: merchant.location.address,
      city: merchant.location.city,
      zip_code: merchant.location.zip_code,
      state_code: merchant.location.state_code,
      country_code: merchant.location.country_code
    )
    coupon.build_avatar_picture(
      uri: merchant.avatar_picture.uri,
      caption: merchant.avatar_picture.caption,
      avatar_crop_x: merchant.avatar_picture.avatar_crop_x,
      avatar_crop_y: merchant.avatar_picture.avatar_crop_y,
      avatar_crop_w: merchant.avatar_picture.avatar_crop_w,
      avatar_crop_h: merchant.avatar_picture.avatar_crop_h,
      bypass_cloudinary_validation: true
    )
    coupon
  end

  def self.build_fr_coupon(fundraiser)
    collection_id = fundraiser.collection.id
    coupon = Coupon.new(collection_id: collection_id)
    coupon.build_location
    coupon
  end

  def fundraisers_count
    self.collections.count - 1
  end

  # STI
  def coupon?
    self.type == 'Coupon'
  end

  def pr_box?
    self.type == 'PrBox'
  end

  private

  def add_to_collection
    self.collections_coupons.create(collection_id: self.collection_id) #Add coupon to owner'ss collection
  end
end