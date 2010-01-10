require 'mechanize'

class Hospital < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :phone
  # validates_presence_of :emergency
  validates_presence_of :longitude
  validates_presence_of :latitude
  
  acts_as_mappable :lat_column_name => "latitude", :lng_column_name => "longitude"
  
  def description
    if self.emergency
      "Has A&E department. #{self.phone}."
    else
      "No A&E department. #{self.phone}."
    end
  end
  
  include GeoKit::Geocoders
  
  def self.import_all!
    transaction do
      destroy_all
      agent = WWW::Mechanize.new
      page = agent.get('http://www.drfoster.co.uk/Guides/objectlist.aspx?w=31')
    
      form = page.forms.with.name("hospFormNHS")
      select_field = form.fields.with.name("obid")
      select_field.options[1..-1].each do |hosp_id| # skip first one
        select_field.value = hosp_id
        page = form.submit
        puts page.uri.to_s
      
        title = page.at("h1").inner_html.split(',')[0..-2].join(",")

        raw_address = page.search("td")[1].inner_html
        regexp = /\b[A-PR-UWYZ][A-HK-Y0-9][A-HJKSTUW0-9]?[ABEHMNPRVWXY0-9]? {1,2}[0-9][ABD-HJLN-UW-Z]{2}\b/
        postcode = regexp.match(raw_address)[0]
      
        result = YahooGeocoder.geocode(postcode + ", UK")
      
        has_emergency = page.search("body").inner_text.include?("Accident and Emergency")
        phone = page.search("td")[3].inner_html
      
        hospital = Hospital.new
        hospital.name = title
        hospital.longitude = result.lng
        hospital.latitude = result.lat
        hospital.phone = phone
        puts has_emergency.inspect
        hospital.emergency = has_emergency
        # has_emergency ? hospital.description = "Has A&E. #{phone}." : hospital.description = "No A&E. #{phone}."
        hospital.save!
      
        puts "Hospital found: #{title} @ #{postcode}: #{result.lat},#{result.lng}"
      
      end
    end
    
  end
  
end