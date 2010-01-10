class CreatePostOffices < ActiveRecord::Migration
  def self.up
    create_table :post_offices do |t|
      t.string :name
      t.text :address
      t.decimal  "latitude",   :precision => 20, :scale => 17
      t.decimal  "longitude",  :precision => 20, :scale => 17
      t.timestamps
    end
  end

  def self.down
    drop_table :post_offices
  end
end
