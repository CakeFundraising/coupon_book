class AddTokenToMediaAffiliateCampaigns < ActiveRecord::Migration
  def change
    add_column :media_affiliate_campaigns, :token, :string
  end
end
