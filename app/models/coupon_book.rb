class CouponBook < ActiveRecord::Base
  has_many :categories, -> { order("position ASC") }, dependent: :destroy
  has_many :coupons, dependent: :destroy

  validates :categories, length: {maximum: 5}

  def fundraiser
    Fundraiser.fetch(self.fundraiser_id)
  end
end