class CreatePubs < ActiveRecord::Migration
  def self.up
    create_table :pubs do |t|
      t.string :name
      t.column :latitude, :decimal, :precision => 20, :scale => 17
      t.column :longitude, :decimal, :precision => 20, :scale => 17
      t.timestamps
    end
  end

  def self.down
    drop_table :pubs
  end
end
