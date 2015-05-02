class Category < ActiveRecord::Base
  belongs_to :coupon_book

  has_many :categories_coupons, -> { order("categories_coupons.position ASC") }
  has_many :coupons, through: :categories_coupons

  accepts_nested_attributes_for :categories_coupons, allow_destroy: true, reject_if: :all_blank

  acts_as_list scope: :coupon_book

  validates :name, :coupon_book_id, presence: true

  scope :persisted, ->{ where.not(id: nil) }
  scope :latest, ->{ order('categories.created_at DESC') }
  scope :with_coupons, ->{ eager_load(:coupons) }

  def update_coupons!(coupons)
    coupons.each_with_index do |coupon, index|
      coupon_position = index + 1
      coupon_id = coupon.gsub('coupons_', '').to_i

      if self.coupons.exists?(coupon_id)
        cc = self.categories_coupons.by_coupon_and_category(coupon_id, self.id)
        cc.set_list_position(coupon_position)
      else
        self.categories_coupons.create(coupon_id: coupon_id, position: coupon_position)
      end
    end
  end
end