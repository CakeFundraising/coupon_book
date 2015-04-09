class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :avatar
      t.string :avatar_caption
      t.string :banner
      t.string :banner_caption
      t.string :picturable_type
      t.integer :picturable_id
      t.integer :avatar_crop_x
      t.integer :avatar_crop_y
      t.integer :avatar_crop_w
      t.integer :avatar_crop_h
      t.integer :banner_crop_x
      t.integer :banner_crop_y
      t.integer :banner_crop_w
      t.integer :banner_crop_h
      t.string :qrcode
      t.integer :qrcode_crop_x
      t.integer :qrcode_crop_y
      t.integer :qrcode_crop_w
      t.integer :qrcode_crop_h
      t.timestamps
    end
  end
end
