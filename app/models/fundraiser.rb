class Fundraiser < User
  has_one :collection, as: :owner, dependent: :destroy

  has_many :coupon_books, dependent: :destroy
  has_many :subscriptors, as: :object
  has_many :vouchers, as: :owner
end