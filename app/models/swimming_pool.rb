class SwimmingPool < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :longitude
  validates_presence_of :latitude
  
  acts_as_mappable :lat_column_name => "latitude", :lng_column_name => "longitude"
  
  def self.import_all!
    require "rexml/document"
    include REXML
    kmlroot = (Document.new(File.new(source_path))).root
    placemarks = kmlroot.elements.to_a("//Placemark")
    
    SwimmingPool.transaction do
      
      SwimmingPool.delete_all
      
      placemarks.each do |p|
        sp = SwimmingPool.new
        sp.name = p.elements["name"].text
        coords = p.elements["Point"].elements["coordinates"].text.split(",")
        sp.longitude = coords[0]
        sp.latitude = coords[1]
        sp.description = p.elements["description"].text
        sp.save!
      end
    end
    
  end
  
  def self.source_path
    File.join(RAILS_ROOT, 'data', 'activeplaces.kml')
  end
  
end
