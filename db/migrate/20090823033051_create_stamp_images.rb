class CreateStampImages < ActiveRecord::Migration
  def self.up
    create_table :stamp_images do |t|
      t.integer :user_id
      t.datetime :generated_at
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :stamp_images
  end
end
