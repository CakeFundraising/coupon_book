class CouponBook < ActiveRecord::Base
  has_many :categories, -> { order("position ASC") }

  def fundraiser
    Fundraiser.fetch(self.fundraiser_id)
  end

end