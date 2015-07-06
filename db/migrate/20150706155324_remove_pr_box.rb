class RemovePrBox < ActiveRecord::Migration
  def change
    drop_table :pr_boxes
    drop_table :collection_pr_boxes
    drop_table :categories_pr_boxes

    add_column :coupons, :type, :string
    remove_column :coupons, :pr_box_flag, :boolean
  end
end
