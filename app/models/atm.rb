# require 'json'
require 'open-uri'

class ATM
  
  attr_accessor :name, :longitude, :latitude
  
  def self.find_at_location(lon, lat, limit)
    url = "http://developer.multimap.com/API/search/1.2/OA0709300000001541?qs=#{lon},#{lat}&dataSource=mm.poi.global.general.atm"
    doc = Hpricot::XML(open(url))
    records = doc.search("Record")[0..limit-1]
    
    records.map do |record|
      atm = ATM.new
      atm.latitude = record.at("Lat").inner_html
      atm.longitude = record.at("Lon").inner_html
      atm.name = record.at("//Field[@name='Name']").inner_html
      atm
    end
  end
  
  def description
    nil
  end
  
  # def self.find_at_location(lon, lat, free_only = false)
  #     results = JSON.parse(`curl -H "Referer: http://locator.link.co.uk/" -H "X-Requested-With: XMLHttpRequest" -d "q=list&ne=#{lon+0.1}%2C#{lat+0.1}&sw=#{lon-0.1}%2C#{lat-0.1}&ll=#{lon}%2C#{lat}&st=atm&mptu=N&pms=N&wc=N&ta=N&height=A&_=" "http://locator.link.co.uk/ATMWebLocator/LocatorDataServlet" -s`)
  #     
  #     all_atms = results.map do |result|
  #       atm = ATM.new
  #       atm.name = result["premises"]
  #       atm.street = result["streetAddress"]
  #       atm.longitude = result["longitude"]
  #       atm.latitude = result["latitude"]
  #       atm.charge = result["charge"].to_f
  #       atm
  #     end
  #     
  #     if free_only
  #       selected_atms = all_atms.select { |a| a.charge == 0 }[0..4]
  #     else
  #       selected_atms = all_atms[0..4]
  #     end
  #     
  #     return selected_atms
  #   end
  #   
  #   def description
  #     if self.charge > 0
  #       return "#{self.street}. There is a charge of &pound;#{"%.2f" % charge} for this machine."
  #     else
  #       return "#{self.street}. There is no charge for this machine."
  #     end    
  #   end
  #   
  #   def url
  #     # needs a blank URL to not break the views.
  #     nil
  #   end
  
end
