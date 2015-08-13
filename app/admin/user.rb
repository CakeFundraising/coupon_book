ActiveAdmin.register User do

  index do
    selectable_column
    column :full_name
    column :email
    column :phone
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :phone
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :password
    end
    f.actions
  end

  permit_params :first_name, :last_name, :email, :phone, :password, :password_confirmation
end