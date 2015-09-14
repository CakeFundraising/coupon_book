class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.monetize :amount
      t.integer :purchase_id
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
