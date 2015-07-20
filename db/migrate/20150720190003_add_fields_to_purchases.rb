class AddFieldsToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :first_name, :string
    add_column :purchases, :last_name, :string
    add_column :purchases, :zip_code, :string
  end
end
