class Collection < ActiveRecord::Base
  has_many :collections_coupons, -> { order("collections_coupons.position ASC") }
  has_many :coupons, through: :collections_coupons
  belongs_to :owner, polymorphic: true

  scope :has_coupons, -> {Collection.where("coupons_count > 0") }
  scope :empty, -> {Collection.where("coupons_count = 0") }
  
  def owner
    self.owner_type.constantize.fetch(self.owner_id)
  end
end