class CollectionsCoupon < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :collection

  acts_as_list scope: :collection

  validates :coupon, :coupon, presence: true
end