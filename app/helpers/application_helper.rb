# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def map_url_from_places(origin, places, size="240x240")
    markers = places.map { |p| "#{p.latitude},#{p.longitude},red#{(places.index(p)+97).chr}"}.join('|')
    
    url = "http://maps.google.com/staticmap?size=#{size}&markers=#{origin[0]},#{origin[1]},blue|#{markers}&key=#{GOOGLE_MAPS_API_KEY}&maptype=mobile&format=png32"
  end
  
  # Request from an iPhone or iPod touch? (Mobile Safari user agent)
  def iphone_user_agent?
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
  end

end
