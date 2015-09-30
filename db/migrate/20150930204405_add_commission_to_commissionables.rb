class AddCommissionToCommissionables < ActiveRecord::Migration
  def change
    add_column :affiliate_campaigns, :commission_percentage, :integer, default: 0, nil: false
    add_column :media_affiliate_campaigns, :commission_percentage, :integer, default: 0, nil: false
  end
end
