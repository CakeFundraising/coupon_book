class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :number
      t.datetime :expires_at
      t.string :status, default: :pending
      t.integer :categories_coupon_id
      t.integer :purchase_id

      t.timestamps null: false
    end

    add_index :vouchers, :number, unique: true
  end
end
