class Collection < ActiveRecord::Base
  has_many :collections_coupons, -> { order("collections_coupons.position ASC") }
  has_many :coupons, through: :collections_coupons
  belongs_to :owner, polymorphic: true

  def owner
    self.owner_type.constantize[self.owner_id]
  end
end