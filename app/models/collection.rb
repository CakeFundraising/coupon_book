class Collection < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  has_many :collections_coupons, -> { order("collections_coupons.position ASC") }
  has_many :coupons, through: :collections_coupons

  has_many :collection_pr_boxes, -> { order("collection_pr_boxes.position ASC") }
  has_many :pr_boxes, through: :collection_pr_boxes

  def owner
    self.owner_type.constantize.fetch(self.owner_id)
  end
end