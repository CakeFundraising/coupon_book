class CreateCategoriesPrBoxes < ActiveRecord::Migration
  def change
    create_table :categories_pr_boxes do |t|
      t.integer :category_id
      t.integer :pr_box_id
      t.integer :position

      t.timestamps null: false
    end
  end
end
