class CreateExtraClicks < ActiveRecord::Migration
  def change
    create_table :extra_clicks do |t|
      t.boolean :bonus, default: false
      t.integer :browser_id
      t.references :clickable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
