class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.string :country_code
      t.string :state_code
      t.string :zip_code
      t.string :city
      t.string :locatable_type
      t.integer :locatable_id

      t.timestamps null: false
    end
  end
end
