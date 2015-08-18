class AddFlagsToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :should_charge, :boolean, default: true
    add_column :purchases, :should_notify, :boolean, default: true
  end
end
