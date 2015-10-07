class AddPaidToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :paid, :boolean, default: false, index: true
  end
end
