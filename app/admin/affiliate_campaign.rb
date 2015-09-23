ActiveAdmin.register AffiliateCampaign do
  decorate_with AffiliateCampaignDecorator

  index do
    selectable_column

    column :affiliate_name
    column :coupon_book
    column :community
    
    actions
  end

  action_item only:[:show] do
    link_to "See Page", affiliate_campaign_path(id: resource)
  end

  permit_params :first_name, :last_name, :phone, :email, :url, :organization_name, :story, :community_id, :use_stripe, :check_recipient_name
end