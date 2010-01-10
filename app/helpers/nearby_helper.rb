module NearbyHelper

  def google_maps_link(place)
    link_to "Google map", "http://maps.google.com/maps?q=#{place.latitude},#{place.longitude}(#{place.name})"
  end
  
end
