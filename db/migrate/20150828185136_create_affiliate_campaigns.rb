class CreateAffiliateCampaigns < ActiveRecord::Migration
  def change
    create_table :affiliate_campaigns do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :url
      t.string :organization_name
      t.text :story
      t.integer :affiliate_id
      t.integer :coupon_book_id

      t.timestamps null: false
    end
  end
end
