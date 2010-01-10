class NearbyController < ApplicationController

  before_filter :get_location
  before_filter :set_friendly_name
  
  rescue_from FireEagle::FireEagleException, :with => "show_error"

  def index
    if params[:limit]
      params[:limit] = 100 if params[:limit] > 100 # force to limit to 100 max
    end
    
    if @latlon
      respond_to do |format|
        format.html do
          @places = Place.find_at_location(subdomain, @latlon, (params[:limit] || 5))
          logger.info "iamnear_log: #{subdomain},#{@latlon[0]},#{@latlon[1]},html"
        end
        
        format.kml do
          @places = Place.find_at_location(subdomain, @latlon, (params[:limit] || 10))
          logger.info "iamnear_log: #{subdomain},#{@latlon[0]},#{@latlon[1]},kml"
        end
        format.json do
          @places = Place.find_at_location(subdomain, @latlon, (params[:limit] || 10))
          logger.info "iamnear_log: #{subdomain},#{@latlon[0]},#{@latlon[1]},json"
          render :json => @places.to_json(:methods => [ :description ], :except => [ :created_at, :updated_at ])
        end
      end
    else
      render :action => "search"
    end
  end
  
  def show_error
    # just render 
  end
  
  private
  
  def set_friendly_name
    case subdomain
    when "pubs"
      @friendly_name = "pubs"
    when "cats"
      @friendly_name = "cats"
    when "megaliths"
      @friendly_name = "megaliths"
    when "atms"
      @friendly_name = "ATMs"
    when "postoffices"
      @friendly_name = "post offices"
    when "interestingthings"
      @friendly_name = "interesting things"
    when "hospitals"
      @friendly_name = "hospitals"
    when "rocketstrikes"
      @friendly_name = "rocket strikes"
    when "snowmen"
      @friendly_name = "snow men"
    when "books"
      @friendly_name = "books"
    when "swimmingpools"
      @friendly_name = "swimming pools"
    when "postboxes"
      @friendly_name = "postboxes"
    end
    
  end
    
end
