# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include HoptoadNotifier::Catcher
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'ae59579aa778fc082257ec49bd9c4fdb'
  
  include GeoKit::Geocoders
  
  def get_location
    if params[:fireeagle]
      get_fireeagle_location
    else
      get_search_location
    end
  end
  
  def get_search_location
    if params[:q]
      result = YahooGeocoder.geocode(params[:q])
      @latlon = [result.lat, result.lng]
      @location_name = params[:q]
    else
      # @latlon = [51, 0]
      @location_name = "...?"
    end
  end
  
  def get_fireeagle_location
    if has_fireeagle_credentials? # fetch current fe location
      fe = FireEagle::Client.new(:consumer_key => CONSUMER_KEY, :consumer_secret => CONSUMER_SECRET, :access_token => session[:access_token], :access_token_secret => session[:access_token_secret])
      
      @fireeagle_location = fe.user.best_guess
      @location_name = @fireeagle_location.name
      @latlon = get_centre_point(@fireeagle_location.geo)
    else # auth against fe
      fe = FireEagle::Client.new(:consumer_key => CONSUMER_KEY, :consumer_secret => CONSUMER_SECRET)
      callback_url = url_for(:controller => 'oauth', :action => 'auth', :only_path => false, :subdomain => 'www')
      request_token = fe.get_request_token(callback_url)
      
      pp request_token.inspect

      session[:request_token] = request_token.token
      session[:request_token_secret] = request_token.secret
      session[:subdomain] = subdomain
      
      pp session.inspect

      redirect_to fe.authorization_url
    end
  end
  
  helper_method :has_fireeagle_credentials?
  
  def has_fireeagle_credentials?
    session[:access_token] && session[:access_token_secret]
  end
  
  def get_centre_point(georuby)
    case georuby
    when GeoRuby::SimpleFeatures::Point
      [georuby.lat, georuby.lon]
    when GeoRuby::SimpleFeatures::Envelope
      [(georuby.upper_corner.lat + georuby.lower_corner.lat)/2, (georuby.upper_corner.lng + georuby.lower_corner.lng)/2]
    end
  end
  
  def subdomain
    request.subdomains.first
  end
  
  helper_method :subdomain
  
  def url_for_subdomain(subdomain)
    if request.port == 80
      "http://#{subdomain}.#{request.domain}"
    else
      "http://#{subdomain}.#{request.domain}:#{request.port}"
    end
  end
  
  def url_for(options = {}, *params) # :nodoc:
    if options[:subdomain] then
      options[:only_path] = false
      host = []
      host << options.delete(:subdomain)
      host << request.subdomains[1..-1] if request.subdomains.size > 1
      host << request.domain
      options[:host] = host.join('.')
      options[:host] << ":#{request.port}" if request.port != 80
   end

   return super(options, *params)
  end
  
  def subdomains_to_class
    {
      "pubs" => Pub,
      "megaliths" => Megalith
    }
  end
  
end
