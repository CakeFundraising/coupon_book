class CreateMediaAffiliateCampaigns < ActiveRecord::Migration
  def change
    create_table :media_affiliate_campaigns do |t|
      t.boolean :use_stripe, default: false
      t.string :recipient_name
      t.integer :media_affiliate_id
      t.integer :community_id

      t.timestamps null: false
    end
  end
end
