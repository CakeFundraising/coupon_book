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
end
