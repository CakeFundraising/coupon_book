class CreateCollectionPrBoxes < ActiveRecord::Migration
  def change
    create_table :collection_pr_boxes do |t|
      t.integer :collection_id
      t.integer :pr_box_id
      t.integer :position
    end
  end
end
