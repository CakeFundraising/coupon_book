class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :position
      t.string :title
      t.datetime :expires_at
      t.text :description
      t.string :promo_code
      t.text :terms_and_conditions
      t.string :url
      t.timestamps
    end
  end
end
