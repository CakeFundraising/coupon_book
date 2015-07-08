ActiveAdmin.register Coupon do
  decorate_with CouponDecorator

  index do
    selectable_column

    column :trunc_title
    column :url_link
    column :price
    column :promo_code
    column :expires_at
    column :status
    
    actions
  end

  show do |c|
    attributes_table do
      row :id
      row :title
      row :description
      row :price
      row :promo_code
      row :url_link
      row :multiple_locations
      row :sponsor_url
      row :sponsor_name
      row :phone
      row :custom_terms
      row :collection_id
      row :created_at
      row :expires_at
      bool_row :universal
      bool_row :order_up
    end
  end

  filter :title
  filter :description
  filter :promo_code
  filter :price_cents
  filter :multiple_locations
  filter :sponsor_name
  filter :phone
  filter :universal
  filter :location
  filter :categories
  filter :status, as: :select, collection: Coupon.statuses[:status].map{|s| s.to_s.titleize }.zip(Coupon.statuses[:status])

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.input :description
      f.input :price
      f.input :url
      f.input :expires_at, as: :string, input_html:{class: 'datepicker'}
      f.input :multiple_locations
      f.input :sponsor_url
      f.input :sponsor_name
      f.input :phone
      f.input :custom_terms
      f.input :collection_id
      f.input :status, as: :select, collection: Coupon.statuses
      f.input :universal
      f.input :order_up
    end

    f.actions
  end

  permit_params :title, :description, :price, :url, :expires_at, :multiple_locations, :sponsor_url, 
  :sponsor_name, :phone, :custom_terms, :collection_id, :status, :universal, :order_up
end
