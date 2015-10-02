ActiveAdmin.register Community do
  decorate_with CommunityDecorator

  action_item only:[:show] do
    link_to "See Page", community_path(id: resource)
  end

  permit_params :slug, :affiliate_commission_percentage, :media_commission_percentage
end