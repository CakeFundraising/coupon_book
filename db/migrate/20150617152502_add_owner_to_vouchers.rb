class AddOwnerToVouchers < ActiveRecord::Migration
  def change
    add_reference :vouchers, :owner, polymorphic: true, index: true
  end
end
