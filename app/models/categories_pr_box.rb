class CategoriesPrBox < ActiveRecord::Base
  belongs_to :pr_box
  belongs_to :category

  delegate :coupon_book, to: :category

  acts_as_list scope: :category

  scope :by_pr_box_and_category, ->(pr_box_id, category_id){ where(pr_box_id: pr_box_id, category_id: category_id).first }

end
