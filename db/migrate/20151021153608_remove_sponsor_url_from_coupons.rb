class RemoveSponsorUrlFromCoupons < ActiveRecord::Migration
  def change
    remove_column :coupons, :sponsor_url, :string
  end
end
