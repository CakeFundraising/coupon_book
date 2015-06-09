ActiveAdmin.register CouponBook do
  decorate_with CouponBookDecorator

  index do
    selectable_column

    column :name
    column 'Main Cause', :main_cause
    column :end_date
    column :status
    column :price
    
    actions
  end

  show title: proc {|cb| "Book: #{cb.name}" } do |cb|
    attributes_table do
      row :id
      row :name
      row :organization_name
      row :price
      row :goal
      row :url_link
      row :launch_date
      row :end_date
      row :main_cause
      row :headline
      row :mission
      row :story
      row :causes
      row :scopes
      row :status
      row :created_at
      row :visitor_action
      row :visitor_url_link
      row :fee_percentage
      bool_row :visible
      row :fundraiser
    end

    panel 'Categories' do
      table_for cb.categories do
        column :name do |category|
          link_to category.name, admin_category_path(category)
        end
        column :subtitle
        column :coupons_count
      end
    end
  end

  filter :name
  filter :organization_name
  filter :main_cause
  filter :launch_date
  filter :end_date
  filter :status, as: :select, collection: CouponBook.statuses[:status].map{|s| s.to_s.titleize }.zip(CouponBook.statuses[:status])
  filter :fundraiser
  filter :visible
  filter :price_cents
  filter :goal_cents

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :organization_name
      f.input :price
      f.input :goal
      f.input :url
      f.input :launch_date, as: :string, input_html:{class: 'datepicker'}
      f.input :end_date, as: :string, input_html:{class: 'datepicker'}
      f.input :headline
      f.input :story
      f.input :mission
      f.input :status, as: :select, collection: CouponBook.statuses
      f.input :visitor_action
      f.input :visitor_url
      f.input :fee_percentage
      f.input :visible
      f.input :main_cause, as: :select, collection: CouponBook::CAUSES
      f.input :causes, as: :check_boxes, collection: CouponBook::CAUSES
      f.input :scopes, as: :check_boxes, collection: CouponBook::SCOPES
      f.input :fundraiser_id, as: :select, collection: Fundraiser.all.to_a
    end


    f.actions
  end

  permit_params :name, :organization_name, :mission, :launch_date, :end_date, :story, :goal, :headline, :step, :url, 
  :main_cause, :sponsor_alias, :visitor_url, :visitor_action, :visible, :price, :status, :fee_percentage, :fundraiser_id, scopes: [], causes: []
end