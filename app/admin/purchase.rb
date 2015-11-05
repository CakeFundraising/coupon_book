ActiveAdmin.register Purchase do
  decorate_with PurchaseDecorator

  index do
    selectable_column

    column :email
    column :amount
    column :purchasable
    
    actions
  end

  show title: proc {|p| "Purchase ##{p.id}" } do |p|
    attributes_table do
      row :id
      row :email
      row :card_token
      row :amount
      row :vouchers_count
      row :purchasable
      row :created_at
    end
  end

  filter :coupon_book, as: :polymorphic_select, on: :purchasable, collection: proc{ CouponBook.all }
  filter :affiliate_campaign, as: :polymorphic_select, on: :purchasable, collection: proc{ AffiliateCampaign.all }
  filter :email
  filter :amount_cents
  filter :created_at
  filter :first_name
  filter :last_name
  filter :zip_code
  filter :comment

  action_item only:[:show] do
    link_to "Resend Email", resend_emails_admin_purchase_path(resource), method: :patch
  end

  member_action :resend_emails, method: :patch do
    resource.resend_emails
    redirect_to resource_path, notice: "Emails re-sent to: #{resource.object.email}"
  end

  permit_params :first_name, :last_name, :zip_code, :purchasable_type, :purchasable_id, :card_token, :amount_cents, :email
end
