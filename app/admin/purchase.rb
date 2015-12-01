ActiveAdmin.register Purchase do
  decorate_with PurchaseDecorator

  index do
    selectable_column

    column :full_name
    column :email
    column :amount
    column :purchasable do |p|
      text = p.purchasable.try(:slug) || "Campaign ##{p.purchasable_id}"
      link_to text, purchasable_path(p)
    end
    
    actions
  end

  show title: proc {|p| "Purchase ##{p.id}" } do |p|
    attributes_table do
      row :id
      row :email
      row :full_name
      row :amount
      row :purchasable do
        link_to p.purchasable, purchasable_path(p)
      end
      row :vouchers_page do
        link_to 'See Page', vouchers_purchase_path(p, token: p.token), target: :_blank
      end
      row :vouchers_count do
        link_to p.vouchers_count, admin_vouchers_path(q: {purchase_id_eq: p.id}, order: :id_desc), target: :_blank
      end
      row :created_at
    end
  end

  filter :coupon_book, as: :polymorphic_select, on: :purchasable, collection: proc{ CouponBook.all.map{|cb| [cb.slug, cb.id] } }
  filter :affiliate_campaign, as: :polymorphic_select, on: :purchasable, collection: proc{ AffiliateCampaign.all.map{|ac| [ac.slug || "Campaign ##{ac.id}", ac.id] } }
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

  controller do
    helper_method :purchasable_path

    def purchasable_path(p)
      p.purchasable.is_a?(CouponBook) ? admin_coupon_book_path(p.purchasable) :  admin_affiliate_campaign_path(p.purchasable)
    end
  end


  permit_params :first_name, :last_name, :zip_code, :purchasable_type, :purchasable_id, :card_token, :amount_cents, :email
end
