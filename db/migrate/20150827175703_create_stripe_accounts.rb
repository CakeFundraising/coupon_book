class CreateStripeAccounts < ActiveRecord::Migration
  def change
    create_table :stripe_accounts do |t|
      t.string :uid
      t.string :publishable_key
      t.string :token
      t.string :customer_id
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
