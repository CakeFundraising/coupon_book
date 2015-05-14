class AddSponsorNameToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :sponsor_name, :string
  end
end
