class Merchant < User
  has_one :collection, as: :owner
  has_many :coupons, through: :collection
  has_many :pr_boxes, through: :collection
  has_many :vouchers, as: :owner

  #Analytics
  def total_unique_clicks
    collection.extra_clicks.count
  end

  def total_clicks
    coupons.sum(:extra_clicks_count)
  end

  def total_vouchers_sold
    vouchers.count
  end
end