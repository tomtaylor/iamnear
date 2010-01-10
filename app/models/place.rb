class Place
  
  def self.find_at_location(places, latlon, limit)
    places = places.to_sym
    case places
    when :pubs
      places = Pub.find(:all, :origin => latlon, :order => 'distance ASC', :limit => limit)
      # places = Pub.find_at_location(latlon[0], latlon[1], limit)
    when :megaliths
      places = Megalith.find(:all, :origin => latlon, :order => 'distance ASC', :limit => limit)
    when :atms
      places = ATM.find_at_location(latlon[0], latlon[1], limit)
    when :postoffices
      places = PostOffice.find(:all, :origin => latlon, :order => 'distance ASC', :limit => limit)
    when :interestingthings
      places = InterestingThing.find_at_location(latlon[0], latlon[1], limit)
    when :hospitals
      places = Hospital.find(:all, :origin => latlon, :order => 'distance ASC', :limit => limit)
    when :cats
      places = Cat.find_at_location(latlon[0], latlon[1], limit)
    when :rocketstrikes
      places = RocketStrike.find(:all, :origin => latlon, :order => 'distance ASC', :limit => limit)
    when :snowmen
      places = Snowman.find_at_location(latlon[0], latlon[1], limit)
    when :books
      places = Book.find(:all, :origin => latlon, :order => 'distance ASC', :limit => limit)
    when :swimmingpools
      places = SwimmingPool.find(:all, :origin => latlon, :order => 'distance ASC', :limit => limit)
    when :postboxes
      places = Postbox.find_at_location(latlon[0], latlon[1], limit)
    else
      raise ActiveRecord::RecordNotFound
    end
  end

end
