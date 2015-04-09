class Coupon < ActiveRecord::Base
  belongs_to :coupon_book, touch: true
  belongs_to :coupon_category

  include Picturable

  acts_as_list scope: :coupon_category

  validates :title, :description, :expires_at, presence: true
end