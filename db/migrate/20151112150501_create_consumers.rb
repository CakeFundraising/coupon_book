class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :zip_code
      t.references :origin, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
