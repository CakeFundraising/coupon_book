class AddHideNameToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :hide_name, :boolean, default: false
  end
end
