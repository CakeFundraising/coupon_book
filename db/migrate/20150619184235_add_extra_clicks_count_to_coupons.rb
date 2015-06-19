class AddExtraClicksCountToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :extra_clicks_count, :integer
    add_column :pr_boxes, :extra_clicks_count, :integer
  end
end
