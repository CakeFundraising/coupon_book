class AddAffiliateCampaignRateToCouponBooks < ActiveRecord::Migration
  def change
    add_column :coupon_books, :affiliate_campaign_rate, :integer, default: 0
    add_column :affiliate_campaigns, :campaign_rate, :integer, default: 0
    rename_column :affiliate_campaigns, :commission_percentage, :community_rate
  end
end
