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
      row :purchasable
      row :created_at
    end
  end

  permit_params :first_name, :last_name, :zip_code, :purchasable_type, :purchasable_id, :card_token, :amount_cents, :email
end
