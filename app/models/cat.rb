class Cat
  
  attr_accessor :name, :longitude, :latitude, :owner, :id, :farm, :server, :secret
  
  def self.find_at_location(lon, lat, limit)
    doc = Hpricot(open(uri(lon, lat, 100)))
    photo_elements = doc.search("//photo")
    
    seen_locations = []
    cats = []
    
    until cats.length == limit || photo_elements.empty? do
      element = photo_elements.shift
      location = Graticule::Location.new(:latitude => element[:latitude].to_f, :longitude => element[:longitude].to_f)
      next if seen_locations.select { |l| Graticule::Distance::Haversine.distance(l, location) < 0.05 }.length > 0
      cat = self.new
      cat.longitude = element[:longitude]
      cat.latitude = element[:latitude]
      cat.name = element[:title]
      cat.owner = element[:owner]
      cat.id = element[:id]
      cat.farm = element[:farm]
      cat.server = element[:server]
      cat.secret = element[:secret]
      # seen_locations << "#{element[:longitude]},#{element[:latitude]}"
      seen_locations << location
      cats << cat
    end
    
    return cats
    
    # photo_elements.map do |element|
    #   cat = self.new
    #   cat.longitude = element[:longitude]
    #   cat.latitude = element[:latitude]
    #   cat.name = element[:title]
    #   cat.owner = element[:owner]
    #   cat.id = element[:id]
    #   cat.farm = element[:farm]
    #   cat.server = element[:server]
    #   cat.secret = element[:secret]
    #   seen_locations << "#{element[:longitude]},#{element[:latitude]}"
    #   cat
    # end
  end
  
  def description
    "<a href=\"http://www.flickr.com/photos/#{self.owner}/#{self.id}\"><img src=\"#{image_url}\"</a>"
  end
  
  private
  
  def image_url
    "http://farm#{farm}.static.flickr.com/#{server}/#{id}_#{secret}_t.jpg"
  end
  
  def self.uri(lat, lon, limit)
    URI::Generic.build(
      :scheme => "http",
      :host => "api.flickr.com",
      :path => "/services/rest/",
      :query => hash_to_query_string(
        :method => "flickr.photos.search",
        :api_key => "9a913a63e4a86307b9957215963ae24e",
        :lat => lat,
        :lon => lon,
        :per_page => limit,
        :radius => "20",
        :radius_units => "mi",
        # :sort => "interestingness-desc",
        :tags => "cat, cats, kitten, kittens",
        :tag_mode => "any",
        :extras => "geo"
        # :min_taken_date => from.to_s(:db),
        # :max_taken_date => to.to_s(:db)
      )
    ).to_s
  end

  def self.hash_to_query_string(args={})
    args.map { |k,v| "%s=%s" % [URI.encode(k.to_s), URI.encode(v.to_s)] }.join('&') unless args.blank?
  end
  
end