ActiveAdmin.register CouponBook do
  decorate_with CouponBookDecorator

  index do
    selectable_column

    column :name
    column 'Main Cause', :main_cause
    column :end_date
    column :status
    column :price_cents
    
    actions
  end
  
end