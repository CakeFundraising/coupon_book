class AddRaisedToCampaigns < ActiveRecord::Migration
  def change
    add_monetize :coupon_books, :raised
    add_monetize :affiliate_campaigns, :raised
  end
end
