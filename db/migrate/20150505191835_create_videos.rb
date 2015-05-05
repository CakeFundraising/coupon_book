class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :recordable_type
      t.integer :recordable_id
      t.string :url
      t.string :provider
      t.string :thumbnail
      t.boolean :auto_show, default: false
    end
  end
end
