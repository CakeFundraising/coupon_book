class RemoveParentFromPrBoxes < ActiveRecord::Migration
  def change
    remove_column :pr_boxes, :parent_id, :integer
    remove_column :pr_boxes, :parent_type, :string
    add_column :pr_boxes, :flag, :string
    add_column :pr_boxes, :collection_id, :integer
  end
end
