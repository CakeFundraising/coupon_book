class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :string, null: false, default: 'User'
    add_column :users, :tax_exempt, :boolean, default: false
  end
end
