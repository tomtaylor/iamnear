class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title, :author, :image_url, :publisher
      t.column :latitude, :decimal, :precision => 20, :scale => 17
      t.column :longitude, :decimal, :precision => 20, :scale => 17
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
