class Fundraiser < User
  include Stripable

  has_one :collection, as: :owner, dependent: :destroy

  has_many :coupon_books, dependent: :destroy
  has_many :subscriptors, as: :object
  has_many :vouchers, as: :owner

  alias_method :campaigns, :coupon_books
end