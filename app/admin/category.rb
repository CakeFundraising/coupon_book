ActiveAdmin.register Category do
  decorate_with CategoryDecorator

  index do
    selectable_column
    column :name
    column :coupon_book
    column :position
    actions
  end

  show title: proc {|c| "Category: #{c.name}" } do |c|
    attributes_table do
      row :name
      row :subtitle
      row :position
      row :coupon_book
      row :coupons_count
      row :created_at
    end

    panel 'Coupons' do
      table_for c.coupons do
        column :title do |coupon|
          link_to coupon.title, admin_coupon_path(coupon)
        end
      end
    end
  end

  permit_params :name, :subtitle, :coupon_book_id, :position
end
