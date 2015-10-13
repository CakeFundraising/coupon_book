class AddNetAmountToCharges < ActiveRecord::Migration
  def change
    rename_column :charges, :amount_cents, :gross_amount_cents
    rename_column :charges, :amount_currency, :gross_amount_currency
    rename_column :charges, :total_fee_cents, :fee_cents
    rename_column :charges, :total_fee_currency, :fee_currency
    add_monetize :charges, :net_amount
  end
end
