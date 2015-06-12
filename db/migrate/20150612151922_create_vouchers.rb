class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :number
      t.string :owner_email, index: true
      t.string :status, default: :pending
      t.datetime :expires_at
      t.integer :categories_coupon_id

      t.timestamps null: false
    end

    add_index :vouchers, :number, unique: true
  end
end
