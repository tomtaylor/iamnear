class Megalith < ActiveRecord::Base
  
  validates_presence_of :url
  validates_presence_of :name
  validates_presence_of :longitude
  validates_presence_of :latitude
  
  acts_as_mappable :lat_column_name => "latitude", :lng_column_name => "longitude"
  
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  
  def description
    "<a href=\"#{self.url}\">Find out more.</a>"
  end
  
  def self.import_all!
    require "rexml/document"
    include REXML
    kmlroot = (Document.new(File.new(source_path))).root
    placemarks = kmlroot.elements.to_a("//Placemark")
    
    Megalith.transaction do
      
      Megalith.delete_all
      
      placemarks.each do |p|
        megalith = Megalith.new
        megalith.name = p.elements["name"].text
        coords = p.elements["Point"].elements["coordinates"].text.split(",")
        megalith.longitude = coords[0]
        megalith.latitude = coords[1]
        megalith.url = URI.extract(p.elements["description"].text)[0]

        megalith.save
      end
    end
    
  end
  
  def self.source_path
    File.join(RAILS_ROOT, 'data', 'megalith.kml')
  end
  
end
