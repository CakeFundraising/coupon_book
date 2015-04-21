class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :position
      t.integer :coupon_book_id
      t.timestamps
    end
  end
end
