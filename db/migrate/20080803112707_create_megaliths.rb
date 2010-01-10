class CreateMegaliths < ActiveRecord::Migration
  def self.up
    create_table :megaliths do |t|
      t.string :name, :url
      t.column :latitude, :decimal, :precision => 20, :scale => 17
      t.column :longitude, :decimal, :precision => 20, :scale => 17
      t.timestamps
    end
  end

  def self.down
    drop_table :megaliths
  end
end
