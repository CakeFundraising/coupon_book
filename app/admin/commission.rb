ActiveAdmin.register Commission do
  decorate_with CommissionDecorator

  actions :all, except: [:edit, :destroy]

  index do
    selectable_column

    column :full_name
    column :email
    column :amount
    column :commissionable do |c|
      text = c.commissionable.try(:slug) || "Campaign ##{c.commissionable_id}"
      link_to text, commissionable_path(c)
    end
    
    actions
  end

  controller do
    helper_method :commissionable_path

    def commissionable_path(c)
      c.commissionable.is_a?(CouponBook) ? admin_coupon_book_path(c.commissionable) :  admin_affiliate_campaign_path(c.commissionable)
    end
  end

  filter :coupon_book, as: :polymorphic_select, on: :commissionable, collection: proc{ CouponBook.all.map{|cb| [cb.slug, cb.id] } }
  filter :affiliate_campaign, as: :polymorphic_select, on: :commissionable, collection: proc{ AffiliateCampaign.all.map{|ac| [ac.slug || "Campaign ##{ac.id}", ac.id] } }
  filter :purchase, as: :select, collection: proc{ Purchase.all.map{|p| ["Purchase ##{p.id}", p.id] } }
  filter :email
  filter :amount_cents
  filter :created_at

  csv do
    column :full_name
    column :plain_email
    column :amount
    column :paid
  end

  #permit_params :slug, :affiliate_commission_percentage, :media_commission_percentage
end