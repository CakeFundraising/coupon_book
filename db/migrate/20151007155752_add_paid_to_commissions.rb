class AddPaidToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :paid, :boolean, default: false, index: true
    add_column :commissions, :transfer_id, :integer
  end
end
