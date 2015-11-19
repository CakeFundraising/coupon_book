ActiveAdmin.register Voucher do
  decorate_with VoucherDecorator

  index do
    selectable_column

    column :id
    column :number
    column :purchase
    column :status
    column :expires_at
    
    actions
  end

  filter :purchase, as: :select, collection: proc{ Purchase.all.map{|p| [p.email, p.id] } }
  filter :number
  filter :status
  filter :expires_at
end