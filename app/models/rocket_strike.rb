class RocketStrike < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :longitude
  validates_presence_of :latitude
  
  acts_as_mappable :lat_column_name => "latitude", :lng_column_name => "longitude"
  
  def description
    read_attribute(:description).strip
  end
  
  def self.import_all!
    require "rexml/document"
    include REXML
    kmlroot = (Document.new(File.new(source_path))).root
    placemarks = kmlroot.elements.to_a("//Placemark")
    
    RocketStrike.transaction do
      
      RocketStrike.delete_all
      
      placemarks.each do |p|
        rs = RocketStrike.new
        rs.name = p.elements["name"].text
        coords = p.elements["Point"].elements["coordinates"].text.split(",")
        rs.longitude = coords[0]
        rs.latitude = coords[1]
        rs.description = p.elements["description"].text
        rs.save!
      end
    end
    
  end
  
  def self.source_path
    File.join(RAILS_ROOT, 'data', 'v2strikes.kml')
  end
  
end
