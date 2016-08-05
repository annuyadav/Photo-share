class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :image
      t.text :tag_line
      t.integer :album_id

      t.timestamps null: false
    end
  end
end
