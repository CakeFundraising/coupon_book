class Category < ActiveRecord::Base
  belongs_to :coupon_book

  has_many :categories_coupons, -> { order("categories_coupons.position ASC") }, dependent: :destroy
  has_many :coupons, through: :categories_coupons

  has_many :categories_pr_boxes, -> { order("categories_pr_boxes.position ASC") }, dependent: :destroy
  has_many :pr_boxes, through: :categories_pr_boxes

  accepts_nested_attributes_for :categories_coupons, allow_destroy: true, update_only: true, reject_if: :all_blank
  accepts_nested_attributes_for :categories_pr_boxes, allow_destroy: true, update_only: true, reject_if: :all_blank

  acts_as_list scope: :coupon_book

  validates :name, :coupon_book_id, presence: true

  scope :persisted, ->{ where.not(id: nil) }
  scope :latest, ->{ order('categories.created_at DESC') }

  scope :with_coupons, ->{ eager_load(:coupons) }
  scope :with_pr_boxes, ->{ eager_load(:pr_boxes) }

  def items
    self.coupons + self.pr_boxes
  end
end