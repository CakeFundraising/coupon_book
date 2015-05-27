class AddCollectionIdToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :collection_id, :integer
  end
end
