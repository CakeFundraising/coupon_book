class CreateAvatarPictures < ActiveRecord::Migration
  def change
    create_table :avatar_pictures do |t|
      t.string :uri
      t.string :caption
      t.integer :avatar_crop_x
      t.integer :avatar_crop_y
      t.integer :avatar_crop_w
      t.integer :avatar_crop_h
      t.string :avatarable_type
      t.integer :avatarable_id

      t.timestamps null: false
    end
  end
end
