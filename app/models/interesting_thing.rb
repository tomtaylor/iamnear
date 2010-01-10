require 'open-uri'

class InterestingThing
  
  attr_accessor :name, :longitude, :latitude, :description
  
  def self.find_at_location(lon, lat, limit)
    doc = Hpricot::XML(open("http://www.geoblogomatic.com/blogs/interesting_posts?location=#{lon},#{lat}&limit=#{limit}"))

    places = doc.search("//Placemark")
    
    all_pos = places.map do |place|
      thing = self.new
      thing.name = place.at("name").inner_html
      thing.description = place.at("description").to_plain_text
      thing.longitude, thing.latitude = place.at("coordinates").inner_html.split(",")
      thing
    end
    
  end
  
end
