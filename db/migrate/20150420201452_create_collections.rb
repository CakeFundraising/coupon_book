class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :owner_id
      t.string :owner_type
    end
  end
end
