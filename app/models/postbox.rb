require 'open-uri'
require 'fastercsv'

class Postbox
  
  attr_accessor :name, :longitude, :latitude, :description
  
  def self.find_at_location(lat, lon, limit)
    url = "http://www.dracos.co.uk/play/locating-postboxes/nearest/?lat=#{lat}&lon=#{lon}&format=csv&limit=#{limit}"
    csv = open(url).read
    
    postboxes = []
    
    FasterCSV.parse(csv, :headers => true) do |row|
      
      postbox = Postbox.new
      postbox.name = row[0]
      postbox.latitude = row[1]
      postbox.longitude = row[2]
      
      last_weekday = row[4]
      last_sat = row[5]
      
      if last_weekday && last_sat
        postbox.description = "Last collection at #{last_weekday} during the week, and #{last_sat} on Saturday."
      elsif last_weekday
        postbox.description = "Last collection at #{last_weekday} during the week."
      elsif last_sat
        postbox.description = "Last collection at #{last_sat} on Saturday."
      else
        postbox.description = "Unknown collection times."
      end
      
      postboxes << postbox
      
    end
    
    return postboxes
  end
  
end