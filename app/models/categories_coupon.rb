class CategoriesCoupon < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :category
  has_many :vouchers

  delegate :coupon_book, to: :category

  acts_as_list scope: :category

  scope :by_coupon_and_category, ->(coupon_id, category_id){ where(coupon_id: coupon_id, category_id: category_id).first }

  def create_voucher(purchase_id)
    unless self.coupon.pr_box?
      self.vouchers.create(purchase_id: purchase_id, expires_at: self.coupon.expires_at, owner: self.coupon.owner)
    end
  end
end