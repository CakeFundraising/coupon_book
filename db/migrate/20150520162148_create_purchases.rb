class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :email
      t.string :card_token
      t.monetize :amount
      t.string :purchasable_type
      t.integer :purchasable_id

      t.timestamps null: false
    end
  end
end
