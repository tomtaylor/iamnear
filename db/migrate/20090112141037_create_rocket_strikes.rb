class CreateRocketStrikes < ActiveRecord::Migration
  def self.up
    create_table :rocket_strikes do |t|
      t.string :name
      t.text :description
      t.column :latitude, :decimal, :precision => 20, :scale => 17
      t.column :longitude, :decimal, :precision => 20, :scale => 17
      t.timestamps
    end
  end

  def self.down
    drop_table :rocket_strikes
  end
end
