class CreateCollectionsCoupons < ActiveRecord::Migration
  def change
    create_table :collections_coupons do |t|
      t.integer :collection_id
      t.integer :coupon_id
      t.integer :position
    end
  end
end
