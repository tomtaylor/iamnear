class CreateHospitals < ActiveRecord::Migration
  def self.up
    create_table :hospitals do |t|
      t.string :name, :phone
      t.column :latitude, :decimal, :precision => 20, :scale => 17
      t.column :longitude, :decimal, :precision => 20, :scale => 17
      t.boolean :emergency
      t.timestamps
    end
  end

  def self.down
    drop_table :hospitals
  end
end
