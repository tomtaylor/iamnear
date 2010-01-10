class PostOffice < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :longitude
  validates_presence_of :latitude
  
  acts_as_mappable :lat_column_name => "latitude", :lng_column_name => "longitude"
  
  def self.import_all
    destroy_all
    require 'json'
    require 'graticule'
    file_path = File.join(Rails.root, 'data', 'postoffices.json')
    file = File.open(file_path, 'r')
    json = JSON.load(file)
    geocode = Graticule.service(:multimap).new "OA0709300000001541"
    i = 0
    json.each do |po_json|
      begin
        i += 1
        po = PostOffice.new
        po.name = po_json['name']
        po.address = po_json['address'].join(', ')
        puts "Geocoding #{i} #{po_json['address'].last}"
        l = geocode.locate(:postal_code => po_json['address'].last, :country => "GB")
        po.longitude = l.longitude
        po.latitude = l.latitude
        puts "#{l.longitude},#{l.latitude}"
        po.save!
      rescue Graticule::Error
        puts "Bad postcode."
        next
      end
    end
  end
  
  def description
    address
  end
  
  def name
    read_attribute(:name) + " Post Office"
  end
end
