ActiveAdmin.register Community do
  decorate_with CommunityDecorator

  action_item only:[:show] do
    link_to "See Page", community_path(id: resource)
  end

  permit_params :slug, :commission_percentage
end