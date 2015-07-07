class Category < ActiveRecord::Base
  belongs_to :coupon_book

  has_many :categories_coupons, -> { order("categories_coupons.position ASC") }, dependent: :destroy
  has_many :items, through: :categories_coupons, source: :coupon
  has_many :coupons, -> { where(type: 'Coupon') }, through: :categories_coupons
  has_many :pr_boxes, -> { where(type: 'PrBox') }, through: :categories_coupons, source: :coupon

  accepts_nested_attributes_for :categories_coupons, allow_destroy: true, update_only: true, reject_if: :all_blank

  acts_as_list scope: :coupon_book

  validates :name, :coupon_book_id, presence: true

  scope :persisted, ->{ where.not(id: nil) }
  scope :latest, ->{ order('categories.created_at DESC') }

  scope :with_items, ->{ eager_load(:items) }

end