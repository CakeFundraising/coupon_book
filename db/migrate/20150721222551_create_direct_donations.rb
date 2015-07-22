class CreateDirectDonations < ActiveRecord::Migration
  def change
    create_table :direct_donations do |t|
      t.string :email
      t.string :card_token
      t.monetize :amount
      t.string :donable_type
      t.integer :donable_id

      t.timestamps null: false
    end
  end
end
