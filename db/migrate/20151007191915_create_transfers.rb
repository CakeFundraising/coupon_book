class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :stripe_id
      t.string :balance_transaction_id
      t.string :kind
      t.monetize :amount
      t.monetize :total_fee
      t.string :status
      t.references :transferable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
