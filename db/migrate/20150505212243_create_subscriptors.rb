class CreateSubscriptors < ActiveRecord::Migration
  def change
    create_table :subscriptors do |t|
      t.string :email
      t.string :object_type
      t.integer :object_id
      t.string :phone
      t.string :organization
      t.text :message
      t.string :name
      t.string :origin_type
      t.integer :origin_id

      t.timestamps null: false
    end
  end
end
