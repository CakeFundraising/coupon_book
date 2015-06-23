class CreateBrowsers < ActiveRecord::Migration
  def change
    create_table :browsers do |t|
      t.string :token, index: true
      t.string :fingerprint, index: true
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
