class CreateCategoriesCoupons < ActiveRecord::Migration
  def change
    create_table :categories_coupons do |t|
      t.integer :category_id
      t.integer :coupon_id
      t.integer :position
      t.timestamps
    end
  end
end
