class Collection < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  has_many :collections_coupons, -> { order("collections_coupons.position ASC") }
  has_many :coupons, -> { where(coupons: {type: 'Coupon'}) }, through: :collections_coupons
  has_many :pr_boxes, -> { where(coupons: {type: 'PrBox'}) }, through: :collections_coupons, source: :coupon, class_name: 'PrBox'

  has_many :extra_clicks, through: :coupons
  has_many :vouchers, through: :coupons

  scope :has_coupons, -> { where("coupons_count > 0") }
  scope :empty, -> { where("coupons_count = 0") }
  
  def owner
    self.owner_type.constantize.fetch(self.owner_id)
  end
end