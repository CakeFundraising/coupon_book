class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :comment
      t.integer :purchase_id

      t.timestamps null: false
    end
  end
end
