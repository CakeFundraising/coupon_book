class CategoriesCoupon < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :category

  delegate :coupon_book, to: :category

  acts_as_list scope: :category
end