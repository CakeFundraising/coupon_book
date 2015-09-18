class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :slug
      t.integer :commission_percentage
      t.integer :coupon_book_id

      t.timestamps null: false
    end
  end
end
