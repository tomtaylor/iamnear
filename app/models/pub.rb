require 'open-uri'

class Pub < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :longitude
  validates_presence_of :latitude
  
  acts_as_mappable :lat_column_name => "latitude", :lng_column_name => "longitude"
  
  def description
    nil
  end
  
  def self.find_at_location(latitude, longitude, limit = 5)
    # url = URI.encode "http://gazetteer.openstreetmap.org/namefinder/search.xml?find=pubs near #{latitude},#{longitude}"
    # 
    # doc = Hpricot(open(url))
    # 
    # pub_entities = doc.search("//named[@info='pub']")[0..limit-1]
    # 
    # pubs = []
    # 
    # pub_entities.each do |entity|
    #   pub = Pub.new
    #   pub.latitude = entity["lat"]
    #   pub.longitude = entity["lon"]
    #   pub.name = entity["name"]
    #   pubs << pub
    # end
    # 
    # pubs
  end
  
end
