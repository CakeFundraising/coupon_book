class Merchant < User
  has_one :collection, as: :owner, dependent: :destroy
  has_many :coupons, through: :collection
  has_many :pr_boxes, through: :collection
  has_many :vouchers, as: :owner

  validates :organization_name, presence: true, if: :registered

  scope :latest, ->{ order('users.created_at DESC') }
  scope :popular, ->{ latest }

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