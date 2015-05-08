class CreatePrBoxes < ActiveRecord::Migration
  def change
    create_table :pr_boxes do |t|
      t.string :headline
      t.text :story
      t.string :url
      t.string :parent_type
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
