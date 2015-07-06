class AddFlagToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :flag, :string
  end
end
