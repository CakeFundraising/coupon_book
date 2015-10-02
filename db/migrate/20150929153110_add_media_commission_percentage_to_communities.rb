class AddMediaCommissionPercentageToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :media_commission_percentage, :integer, default: 0, nil: false

    remove_column :communities, :commission_percentage, :integer
    add_column :communities, :affiliate_commission_percentage, :integer, default: 0, nil: false

    add_column :communities, :screenshot_url, :string
    add_column :communities, :screenshot_version, :string
  end
end
